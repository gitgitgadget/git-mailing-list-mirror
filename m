Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430F71AB6CE
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725573134; cv=none; b=MgTYk3inT+vWEexys/1Jlnyp8u526sDFJNE+a3WCcLB8JVr1IOD0jKFfMH4kSSAlknXF+uRxdUbGaKQiKRoUfEuqC2VYB1CFqI6CIrD4kmjySG3lrsADp0vSQAsdq2WlMgXLHibKdsv7zQQbDXzOS/xRfWOeOKHcJp6xGHeMglY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725573134; c=relaxed/simple;
	bh=u0Yz2E50corh61z1BCQAh8+JborLrHxepJIdUutzSdI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=G/iJTHaX6ZgvW8MxvmfxcO02sCqzMFAXIJARozRb0RaStDvA88riju0y6ChVQ7KAOMHQl9OBndUAuG2tiRDyWRENlpQEyKbWKSUAZe07YYSGGcKWkw+hZRo/E5YqT5H7DiVdhRsfaKpBIvvUCp+BW9EoN9bD0qxYcnIZhSKmoso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ctt2KidK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ctt2KidK"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c3ca32971cso1574022a12.0
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725573129; x=1726177929; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKE4YhmpLUaDI5y3z/lRnrf/0qaBLKWTZB4/HEcdLv8=;
        b=Ctt2KidKYLVXAtNVbVPWxpomKZtH/YRmsP7UxNfGk/o2Q7DscaRz9bfWMzSyAK0n0n
         qq06n1bQfu0rpuvEDF1E8YOcEkoSJxO0xXttbaA8baClSvVNr1FrQ8c0isoRT2o6Pxv5
         O+NvXX+JV4gfLpUFbpsgVn6ULG2NASKJuUx7uTaBlflYq/snZ9PSaF+rSru6/X5WMd46
         KaUJRmZz5uH9i1QzHbzNR7NlVGpS6OQMa+QxG+xT3h/Sagv7EsmyWHLipOvG89S7ajVD
         smOTmQhZJIngeR+2AKRzGKJuxshriL3/alIbyljiCGRW7sxGLdsKEhlDLJMk4Y/sF+Ut
         MKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725573129; x=1726177929;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKE4YhmpLUaDI5y3z/lRnrf/0qaBLKWTZB4/HEcdLv8=;
        b=iKHAMTsWb5JLNi9r9VWll8G8wI6Sg05ozD8VW76eHQgBBiJpdwg25G7xZqwHcXHVLq
         5TTrfCnNjnMSp1/Co/2A5PXGJ1aQNkWMeRyxW2sgtvAQtEQ6tJ0TWCK09oaFBHrMQ2xP
         3nqopF38wQ2ZakoTGzV/FcCMuHCy6KTqTlR5PU2oInOF7HhF77iA3nXl46l08gwqjFoa
         IEzuat+EyW/l7P+xQH9jn67xSNvDM3vrOd5O4LAmgykrfO0N34uYguFW/vGdkqZwyUkU
         Ar/RjBpJbiIBNydPw28HYiqMqnwCKLepLp7TuAQoEeWJo90/0TnhK+zrpN8mhNogZEVr
         9ufw==
X-Gm-Message-State: AOJu0YwTOeaY4ybc8LoElyhM6fpqNHNzqPJbGJB4RkngPqG6Jano+8f8
	Eppa95coODybI5x3UrLSzapHEVPnyatY/quKoYLF+UZ9Xjgi/QtXa83HoQ==
X-Google-Smtp-Source: AGHT+IHt596s3GXf7z3xHFuAPtHkL3goCBGSmdV52b69eLey05uP2GG/f8D2XDUDctv43ygSnDv2oQ==
X-Received: by 2002:a17:906:c156:b0:a86:789c:2d07 with SMTP id a640c23a62f3a-a8a885be5bemr36904466b.4.1725573127935;
        Thu, 05 Sep 2024 14:52:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d02bsm186499366b.109.2024.09.05.14.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:52:07 -0700 (PDT)
Message-Id: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
In-Reply-To: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
References: <pull.1766.v3.git.1723389612.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Sep 2024 21:52:03 +0000
Subject: [PATCH v4 0/3] doc: introducing synopsis para
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

In the continuation of the simplification of manpage editing, the synopsis
processing that was developed for synopsis paragraph style is also applied
to all inline backquoted texts.

Refining the magic regexp took more time than expected, but this one should
really enhance writers'experience. I had to fight a bit more with
asciidoctor, due to discrepancies between version 2.0 on my laptop and the
1.5.6 used by Github actions.

The git-init and git-clone manpages are converted to this new system.

Changes since V1:

 * switch to sed for asciidoc filter and refine the regex for support under
   macOS

Changes since V2:

 * introduce the s macro to freely apply synopsis styling wherever needed,
   without formatting hassle.

Changes since V3:

 * replace s macro by direct processing of literal text at the level of
   output processors.

Jean-Noël Avila (3):
  doc: introduce a synopsis typesetting
  doc: update the guidelines to reflect the current formatting rules
  doc: apply synopsis simplification on git-clone and git-init

 Documentation/CodingGuidelines          | 58 +++++++++--------
 Documentation/asciidoc.conf             | 20 ++++++
 Documentation/asciidoctor-extensions.rb | 87 +++++++++++++++++++++++++
 Documentation/git-clone.txt             | 78 +++++++++++-----------
 Documentation/git-init.txt              | 35 +++++-----
 Documentation/urls.txt                  | 26 ++++----
 ci/install-dependencies.sh              |  1 +
 t/t0450-txt-doc-vs-help.sh              | 11 ++--
 8 files changed, 209 insertions(+), 107 deletions(-)


base-commit: 2e7b89e038c0c888acf61f1b4ee5a43d4dd5e94c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1766%2Fjnavila%2Fdoc_synopsis_para-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1766/jnavila/doc_synopsis_para-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1766

Range-diff vs v3:

 1:  0d7c1dd8f26 ! 1:  c09968d7ccb doc: introduce a synopsis custom paragraph attribute
     @@ Metadata
      Author: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Commit message ##
     -    doc: introduce a synopsis custom paragraph attribute
     +    doc: introduce a synopsis typesetting
      
          In order to follow the common manpage usage, the synopsis of the
          commands needs to be heavily typeset. A first try was performed with
     @@ Commit message
      
          In order to both simplify the writer's task and obtain a consistant
          typesetting in the synopsis, a custom 'synopsis' paragraph type is
     -    created and the backends of asciidoc and asciidoctor take in charge to
     -    correctly add the required typesetting.
     -
     -    additionally, a 's' macro ('s' standing for synopsis) is introduced to
     -    allow writers to freely apply automatic styling whereever required.
     +    created and the processor for backticked text are modified. The
     +    backends of asciidoc and asciidoctor take in charge to correctly add
     +    the required typesetting.
      
          Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
      
       ## Documentation/asciidoc.conf ##
     -@@
     - 
     - [macros]
     - (?su)[\\]?(?P<name>linkgit):(?P<target>\S*?)\[(?P<attrlist>.*?)\]=
     --
     -+(?su)[\\]?(?P<name>s):(?P<target>\S*?)\["(?P<attrlist>.*?)"\]=
     - [attributes]
     - asterisk=&#42;
     - plus=&#43;
      @@ Documentation/asciidoc.conf: ifdef::backend-docbook[]
       {0#<citerefentry>}
       {0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
       {0#</citerefentry>}
      +
     -+[s-inlinemacro]
     -+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[ |()>]|^|\]|&gt;)(\.?[-a-zA-Z0-9:+=~@,\/]+\.?)',r'\1<literal>\2</literal>', '{attrlist}'))}
     ++[literal-inlinemacro]
     ++{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<emphasis>\1</emphasis>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,\/_^\$]+\.?)+)',r'\1<literal>\2</literal>', re.sub(r'(\.\.\.?)([^\]$.])', r'<literal>\1</literal>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
     ++
       endif::backend-docbook[]
       
       ifdef::backend-docbook[]
     @@ Documentation/asciidoc.conf: ifdef::backend-xhtml11[]
       [linkgit-inlinemacro]
       <a href="{git-relative-html-prefix}{target}.html">{target}{0?({0})}</a>
      +
     -+[s-inlinemacro]
     -+{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<em>\1</em>', re.sub(r'([\[ |()>]|^|\]|&gt;)(\.?[-=a-zA-Z0-9:+,@]+\.?)',r'\1<code>\2</code>', '{attrlist}'))}
     ++[literal-inlinemacro]
     ++{eval:re.sub(r'(&lt;[-a-zA-Z0-9.]+&gt;)', r'<em>\1</em>', re.sub(r'([\[\s|()>]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,\/_^\$]+\.?)+)',r'\1<code>\2</code>', re.sub(r'(\.\.\.?)([^\]$.])', r'<code>\1</code>\2', macros.passthroughs[int(attrs['passtext'][1:-1])] if attrs['passtext'][1:-1].isnumeric() else attrs['passtext'][1:-1])))}
      +
      +endif::backend-xhtml11[]
      +
      +ifdef::backend-docbook[]
      +ifdef::doctype-manpage[]
      +[paradef-default]
     -+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@]+\.?+)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<emphasis>\\0</emphasis>!g'"
     ++synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@,\/_^\$]+\.?+)!\\1<literal>\\2</literal>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<emphasis>\\0</emphasis>!g'"
      +endif::doctype-manpage[]
      +endif::backend-docbook[]
      +
      +ifdef::backend-xhtml11[]
      +[paradef-default]
     -+synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@]+\.?)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<em>\\0</em>!g'"
     ++synopsis-style=template="verseparagraph",filter="sed -E 's!([\[ |()>]|^|\])(\.?[-=a-zA-Z0-9:+@,\/_^\$]+\.?)!\\1<code>\\2</code>!g;s!&lt;[-a-zA-Z0-9.]+&gt;!<em>\\0</em>!g'"
       endif::backend-xhtml11[]
      
       ## Documentation/asciidoctor-extensions.rb ##
     -@@ Documentation/asciidoctor-extensions.rb: module Git
     -       end
     -     end
     +@@
     + require 'asciidoctor'
     + require 'asciidoctor/extensions'
     ++require 'asciidoctor/converter/docbook5'
     ++require 'asciidoctor/converter/html5'
       
     -+    class SynopsisMacroProcessor < Asciidoctor::Extensions::InlineMacroProcessor
     -+      use_dsl
     -+
     -+      named :s
     -+      match(/s:\["(.+?)"\]/)
     -+
     -+      def process(parent, target, attrs)
     -+        l = target.gsub(/([\[\] |()]|^|&gt;)(\.?[-a-zA-Z0-9:+=~@,\/]+\.?)/, '\1{empty}`\2`{empty}')
     -+                  .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '__\\1__')
     -+                  .gsub(']', ']{empty}')
     -+
     -+        create_inline parent, :quoted, l, attributes: { 'subs' => :normal }
     -+      end
     -+    end
     -+
     -     class DocumentPostProcessor < Asciidoctor::Extensions::Postprocessor
     -       def process document, output
     -         if document.basebackend? 'docbook'
     + module Git
     +   module Documentation
      @@ Documentation/asciidoctor-extensions.rb: module Git
               output
             end
     @@ Documentation/asciidoctor-extensions.rb: module Git
      +
      +      def process parent, reader, attrs
      +        outlines = reader.lines.map do |l|
     -+          l.gsub(/([\[\] |()>]|^)([-a-zA-Z0-9:+=]+)/, '\1{empty}`\2`{empty}')
     ++          l.gsub(/(\.\.\.?)([^\]$.])/, '`\1`\2')
     ++           .gsub(%r{([\[\] |()>]|^)([-a-zA-Z0-9:+=~@,/_^\$]+)}, '\1{empty}`\2`{empty}')
      +           .gsub(/(<[-a-zA-Z0-9.]+>)/, '__\\1__')
      +           .gsub(']', ']{empty}')
      +        end
      +        create_block parent, :verse, outlines, attrs
      +      end
     ++    end
     ++
     ++    class GitDBConverter < Asciidoctor::Converter::DocBook5Converter
     ++
     ++      extend Asciidoctor::Converter::Config
     ++      register_for 'docbook5'
     ++
     ++      def convert_inline_quoted node
     ++        if (type = node.type) == :asciimath
     ++          # NOTE fop requires jeuclid to process mathml markup
     ++          asciimath_available? ? %(<inlineequation>#{(::AsciiMath.parse node.text).to_mathml 'mml:', 'xmlns:mml' => 'http://www.w3.org/1998/Math/MathML'}</inlineequation>) : %(<inlineequation><mathphrase><![CDATA[#{node.text}]]></mathphrase></inlineequation>)
     ++        elsif type == :latexmath
     ++          # unhandled math; pass source to alt and required mathphrase element; dblatex will process alt as LaTeX math
     ++          %(<inlineequation><alt><![CDATA[#{equation = node.text}]]></alt><mathphrase><![CDATA[#{equation}]]></mathphrase></inlineequation>)
     ++        elsif type == :monospaced
     ++          node.text.gsub(/(\.\.\.?)([^\]$.])/, '<literal>\1</literal>\2')
     ++              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<literal>\2</literal>')
     ++              .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<emphasis>\1</emphasis>')
     ++        else
     ++          open, close, supports_phrase = QUOTE_TAGS[type]
     ++          text = node.text
     ++          if node.role
     ++            if supports_phrase
     ++              quoted_text = %(#{open}<phrase role="#{node.role}">#{text}</phrase>#{close})
     ++            else
     ++              quoted_text = %(#{open.chop} role="#{node.role}">#{text}#{close})
     ++            end
     ++          else
     ++            quoted_text = %(#{open}#{text}#{close})
     ++          end
     ++          node.id ? %(<anchor#{common_attributes node.id, nil, text}/>#{quoted_text}) : quoted_text
     ++        end
     ++      end
     ++    end
     ++
     ++    # register a html5 converter that takes in charge to convert monospaced text into Git style synopsis
     ++    class GitHTMLConverter < Asciidoctor::Converter::Html5Converter
     ++
     ++      extend Asciidoctor::Converter::Config
     ++      register_for 'html5'
     ++
     ++      def convert_inline_quoted node
     ++        if node.type == :monospaced
     ++          node.text.gsub(/(\.\.\.?)([^\]$.])/, '<code>\1</code>\2')
     ++              .gsub(%r{([\[\s|()>.]|^|\]|&gt;)(\.?([-a-zA-Z0-9:+=~@,/_^\$]+\.{0,2})+)}, '\1<code>\2</code>')
     ++              .gsub(/(&lt;[-a-zA-Z0-9.]+&gt;)/, '<em>\1</em>')
     ++
     ++        else
     ++          open, close, tag = QUOTE_TAGS[node.type]
     ++          if node.id
     ++            class_attr = node.role ? %( class="#{node.role}") : ''
     ++            if tag
     ++              %(#{open.chop} id="#{node.id}"#{class_attr}>#{node.text}#{close})
     ++            else
     ++              %(<span id="#{node.id}"#{class_attr}>#{open}#{node.text}#{close}</span>)
     ++            end
     ++          elsif node.role
     ++            if tag
     ++              %(#{open.chop} class="#{node.role}">#{node.text}#{close})
     ++            else
     ++              %(<span class="#{node.role}">#{open}#{node.text}#{close}</span>)
     ++            end
     ++          else
     ++            %(#{open}#{node.text}#{close})
     ++          end
     ++        end
     ++      end
      +    end
         end
       end
       
       Asciidoctor::Extensions.register do
         inline_macro Git::Documentation::LinkGitProcessor, :linkgit
     -+  inline_macro Git::Documentation::SynopsisMacroProcessor
      +  block Git::Documentation::SynopsisBlock
         postprocessor Git::Documentation::DocumentPostProcessor
       end
      
     + ## ci/install-dependencies.sh ##
     +@@ ci/install-dependencies.sh: Documentation)
     + 
     + 	test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
     + 	sudo gem install --version 1.5.8 asciidoctor
     ++	sudo gem install concurrent-ruby
     + 	;;
     + esac
     + 
     +
       ## t/t0450-txt-doc-vs-help.sh ##
      @@ t/t0450-txt-doc-vs-help.sh: txt_to_synopsis () {
       	fi &&
 2:  92f3121cf4e ! 2:  c48649ccd63 doc: update the guidelines to reflect the current formatting rules
     @@ Commit message
      
       ## Documentation/CodingGuidelines ##
      @@ Documentation/CodingGuidelines: Markup:
     +    _<new-branch-name>_
     +    _<template-directory>_
     + 
     +- A placeholder is not enclosed in backticks, as it is not a literal.
     +-
     +  When needed, use a distinctive identifier for placeholders, usually
     +  made of a qualification and a type:
     +    _<git-dir>_
          _<key-id>_
       
     -  When literal and placeholders are mixed, each markup is applied for
     +- When literal and placeholders are mixed, each markup is applied for
      - each sub-entity. If they are stuck, a special markup, called
      - unconstrained formatting is required.
      - Unconstrained formating for placeholders is __<like-this>__
     @@ Documentation/CodingGuidelines: Markup:
      -   ++--sort=++__<key>__
      -   __<directory>__++/.git++
      -   ++remote.++__<name>__++.mirror++
     --
     ++ Git's Asciidoc processor has been tailored to treat backticked text
     ++ as complex synopsis. When literal and placeholders are mixed, you can
     ++ use the backtick notation which will take care of correctly typesetting
     ++ the content.
     ++   `--jobs <n>`
     ++   `--sort=<key>`
     ++   `<directory>/.git`
     ++   `remote.<name>.mirror`
     ++   `ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>`
     + 
      - caveat: ++ unconstrained format is not verbatim and may expand
      - content. Use Asciidoc escapes inside them.
     -+ each sub-entity. If the formatting is becoming too hairy, you can use the
     -+ s:["foo"] formatting macro and let it format the groups for you.
     -+   `--jobs` _<n>_ or s:["--jobs <n>"]
     -+   s:["--sort=<key>
     -+   s:["<directory>/.git"]
     -+   s:["remote.<name>.mirror"]
     -+   s:["ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>"]
     -+
     -+Note that the double-quotes are required by the macro.
     ++As a side effect, backquoted placeholders are correctly typeset, but
     ++this style is not recommended.
       
       Synopsis Syntax
       
 3:  02406b91894 ! 3:  719188da711 doc: apply synopsis simplification on git-clone and git-init
     @@ Documentation/git-clone.txt: git-clone - Clone a repository into a new directory
       
       DESCRIPTION
       -----------
     +@@ Documentation/git-clone.txt: OPTIONS
     + 	to save space when possible.
     + +
     + If the repository is specified as a local path (e.g., `/path/to/repo`),
     +-this is the default, and --local is essentially a no-op.  If the
     ++this is the default, and `--local` is essentially a no-op.  If the
     + repository is specified as a URL, then this flag is ignored (and we
     + never use the local optimizations).  Specifying `--no-local` will
     + override the default when `/path/to/repo` is given, using the regular
      @@ Documentation/git-clone.txt: prevent the unintentional copying of files by dereferencing the symbolic
       links.
       +
       *NOTE*: this operation can race with concurrent modification to the
      -source repository, similar to running `cp -r src dst` while modifying
      -`src`.
     -+source repository, similar to running s:["cp -r <src> <dst>"] while modifying
     ++source repository, similar to running `cp -r <src> <dst>` while modifying
      +_<src>_.
       
       `--no-hardlinks`::
     @@ Documentation/git-clone.txt: If you want to break the dependency of a repository
       objects from the source repository into a pack in the cloned repository.
       
      -`--reference`[`-if-able`] _<repository>_::
     -+s:["--reference[-if-able] <repository>"]::
     ++`--reference[-if-able] <repository>`::
       	If the reference _<repository>_ is on the local machine,
       	automatically setup `.git/objects/info/alternates` to
       	obtain objects from the reference _<repository>_.  Using
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       	standard error stream is not directed to a terminal.
       
      -++--server-option=++__<option>__::
     -+s:["--server-option=<option>"]::
     ++`--server-option=<option>`::
       	Transmit the given string to the server when communicating using
       	protocol version 2.  The given string must not contain a NUL or LF
       	character.  The server's handling of server options, including
       	unknown ones, is server-specific.
      -	When multiple ++--server-option=++__<option>__ are given, they are all
     -+	When multiple s:["--server-option=<option>"] are given, they are all
     ++	When multiple `--server-option=<option>` are given, they are all
       	sent to the other side in the order listed on the command line.
       
       `-n`::
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       	Make a 'bare' Git repository.  That is, instead of
       	creating _<directory>_ and placing the administrative
      -	files in _<directory>_`/.git`, make the _<directory>_
     -+	files in s:["<directory>/.git"], make the _<directory>_
     ++	files in `<directory>/.git`, make the _<directory>_
       	itself the `$GIT_DIR`. This obviously implies the `--no-checkout`
       	because there is nowhere to check out the working tree.
       	Also the branch heads at the remote are copied directly
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       	working directory as needed.
       
      -++--filter=++__<filter-spec>__::
     -+s:["--filter=<filter-spec>"]::
     ++`--filter=<filter-spec>`::
       	Use the partial clone feature and request that the server sends
       	a subset of reachable objects according to a given object filter.
       	When using `--filter`, the supplied _<filter-spec>_ is used for
       	the partial clone filter. For example, `--filter=blob:none` will
       	filter out all blobs (file contents) until needed by Git. Also,
      -	++--filter=blob:limit=++__<size>__ will filter out all blobs of size
     -+	s:["--filter=blob:limit=<size>"] will filter out all blobs of size
     ++	`--filter=blob:limit=<size>` will filter out all blobs of size
       	at least _<size>_. For more details on filter specifications, see
       	the `--filter` option in linkgit:git-rev-list[1].
       
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       	run on the other end.
       
      -++--template=++__<template-directory>__::
     -+s:["--template=<template-directory>"]::
     ++`--template=<template-directory>`::
       	Specify the directory from which templates will be used;
       	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
       
      -`-c` __<key>__++=++__<value>__::
      -`--config` __<key>__++=++__<value>__::
     -+`-c` s:["<key>=<value>"]::
     -+`--config` s:["<key>=<value>"]::
     ++`-c` `<key>=<value>`::
     ++`--config` `<key>=<value>`::
       	Set a configuration variable in the newly-created repository;
       	this takes effect immediately after the repository is
       	initialized, but before the remote history is fetched or any
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       variables do not take effect until after the initial fetch and checkout.
       Configuration variables known to not take effect are:
      -++remote.++__<name>__++.mirror++ and ++remote.++__<name>__++.tagOpt++.  Use the
     -+s:["remote.<name>.mirror"] and s:["remote.<name>.tagOpt"].  Use the
     ++`remote.<name>.mirror` and `remote.<name>.tagOpt`.  Use the
       corresponding `--mirror` and `--no-tags` options instead.
       
      -`--depth` _<depth>_::
     -+s:["--depth <depth>"]::
     ++`--depth <depth>`::
       	Create a 'shallow' clone with a history truncated to the
       	specified number of commits. Implies `--single-branch` unless
       	`--no-single-branch` is given to fetch the histories near the
     @@ Documentation/git-clone.txt: objects from the source repository into a pack in t
       	also pass `--shallow-submodules`.
       
      -++--shallow-since=++__<date>__::
     -+s:["--shallow-since=<date>"]::
     ++`--shallow-since=<date>`::
       	Create a shallow clone with a history after the specified time.
       
      -++--shallow-exclude=++__<revision>__::
     -+s:["--shallow-exclude=<revision>"]::
     ++`--shallow-exclude=<revision>`::
       	Create a shallow clone with a history, excluding commits
       	reachable from a specified remote branch or tag.  This option
       	can be specified multiple times.
       
      -`--`[`no-`]`single-branch`::
     -+s:["--[no-]single-branch"]::
     ++`--[no-]single-branch`::
       	Clone only the history leading to the tip of a single branch,
       	either specified by the `--branch` option or the primary
       	branch remote's `HEAD` points at.
     -@@ Documentation/git-clone.txt: corresponding `--mirror` and `--no-tags` options instead.
     - 
     - `--no-tags`::
     - 	Don't clone any tags, and set
     --	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
     -+	s:["remote.<remote>.tagOpt=--no-tags"] in the config, ensuring
     - 	that future `git pull` and `git fetch` operations won't follow
     - 	any tags. Subsequent explicit tag fetches will still work,
     - 	(see linkgit:git-fetch[1]).
      @@ Documentation/git-clone.txt: maintain a branch with no references other than a single cloned
       branch. This is useful e.g. to maintain minimal clones of the default
       branch of some repository for search indexing.
       
      -`--recurse-submodules`[`=`{empty}__<pathspec>__]::
     -+s:["--recurse-submodules[=<pathspec>]"]::
     ++`--recurse-submodules[=<pathspec>]`::
       	After the clone is created, initialize and clone submodules
     - 	within based on the provided _<pathspec>_.  If no _=<pathspec>_ is
     +-	within based on the provided _<pathspec>_.  If no _=<pathspec>_ is
     ++	within based on the provided _<pathspec>_.  If no `=<pathspec>` is
       	provided, all submodules are initialized and cloned.
     -@@ Documentation/git-clone.txt: branch of some repository for search indexing.
     + 	This option can be given multiple times for pathspecs consisting
     + 	of multiple entries.  The resulting clone has `submodule.active` set to
     +-	the provided pathspec, or "." (meaning all submodules) if no
     ++	the provided pathspec, or "`.`" (meaning all submodules) if no
     + 	pathspec is provided.
       +
       Submodules are initialized and cloned using their default settings. This is
     - equivalent to running
     --`git submodule update --init --recursive <pathspec>` immediately after
     -+s:["git submodule update --init --recursive <pathspec>"] immediately after
     - the clone is finished. This option is ignored if the cloned repository does
     +@@ Documentation/git-clone.txt: the clone is finished. This option is ignored if the cloned repository does
       not have a worktree/checkout (i.e. if any of `--no-checkout`/`-n`, `--bare`,
       or `--mirror` is given)
       
      -`--`[`no-`]`shallow-submodules`::
     -+s:["--[no-]shallow-submodules"]::
     ++`--[no-]shallow-submodules`::
       	All submodules which are cloned will be shallow with a depth of 1.
       
      -`--`[`no-`]`remote-submodules`::
     -+s:["--[no-]remote-submodules"]::
     ++`--[no-]remote-submodules`::
       	All submodules which are cloned will use the status of the submodule's
       	remote-tracking branch to update the submodule, rather than the
       	superproject's recorded SHA-1. Equivalent to passing `--remote` to
       	`git submodule update`.
       
      -`--separate-git-dir=`{empty}__<git-dir>__::
     -+s:["--separate-git-dir=<git-dir>"]::
     ++`--separate-git-dir=<git-dir>`::
       	Instead of placing the cloned repository where it is supposed
       	to be, place the cloned repository at the specified directory,
       	then make a filesystem-agnostic Git symbolic link to there.
     @@ Documentation/git-clone.txt: branch of some repository for search indexing.
       	tree.
       
      -`--ref-format=`{empty}__<ref-format>__::
     -+s:["--ref-format=<ref-format>"]::
     ++`--ref-format=<ref-format>`::
       
       Specify the given ref storage format for the repository. The valid values are:
       +
     @@ Documentation/git-clone.txt: _<directory>_::
       	is only allowed if the directory is empty.
       
      -`--bundle-uri=`{empty}__<uri>__::
     -+s:["--bundle-uri=<uri>"]::
     ++`--bundle-uri=<uri>`::
       	Before fetching from the remote, fetch a bundle from the given
       	_<uri>_ and unbundle the data into the local repository. The refs
       	in the bundle will be stored under the hidden `refs/bundle/*`
     @@ Documentation/git-init.txt: Only print error and warning messages; all other out
       
      -++--object-format=++__<format>__::
      -
     -+s:["--object-format=<format>"]::
     ++`--object-format=<format>`::
       Specify the given object _<format>_ (hash algorithm) for the repository.  The valid
       values are `sha1` and (if enabled) `sha256`.  `sha1` is the default.
       +
     @@ Documentation/git-init.txt: Only print error and warning messages; all other out
       
      -++--ref-format=++__<format>__::
      -
     -+s:["--ref-format=<format>"]::
     ++`--ref-format=<format>`::
       Specify the given ref storage _<format>_ for the repository. The valid values are:
       +
       include::ref-storage-format.txt[]
       
      -++--template=++__<template-directory>__::
      -
     -+s:["--template=<template-directory>"]::
     ++`--template=<template-directory>`::
       Specify the directory from which templates will be used.  (See the "TEMPLATE
       DIRECTORY" section below.)
       
      -++--separate-git-dir=++__<git-dir>__::
      -
     -+s:["--separate-git-dir=<git-dir>"]::
     ++`--separate-git-dir=<git-dir>`::
       Instead of initializing the repository as a directory to either `$GIT_DIR` or
       `./.git/`, create a text file there containing the path to the actual
       repository.  This file acts as a filesystem-agnostic Git symbolic link to the
      @@ Documentation/git-init.txt: repository.
     + +
       If this is a reinitialization, the repository will be moved to the specified path.
       
     - `-b` _<branch-name>_::
     +-`-b` _<branch-name>_::
      -++--initial-branch=++__<branch-name>__::
      -
     -+s:["--initial-branch=<branch-name>"]::
     ++`-b <branch-name>`::
     ++`--initial-branch=<branch-name>`::
       Use _<branch-name>_ for the initial branch in the newly created
       repository.  If not specified, fall back to the default name (currently
       `master`, but this is subject to change in the future; the name can be
       customized via the `init.defaultBranch` configuration variable).
       
      -++--shared++[++=++(`false`|`true`|`umask`|`group`|`all`|`world`|`everybody`|_<perm>_)]::
     -+s:["--shared[=(false|true|umask|group|all|world|everybody|<perm>)]"]::
     ++`--shared[=(false|true|umask|group|all|world|everybody|<perm>)]`::
       
       Specify that the Git repository is to be shared amongst several users.  This
       allows users belonging to the same group to push into that
     @@ Documentation/urls.txt: Git supports ssh, git, http, and https protocols (in add
      -- ++git://++__<host>__{startsb}:__<port>__{endsb}++/++__<path-to-git-repo>__
      -- ++http++{startsb}++s++{endsb}++://++__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
      -- ++ftp++{startsb}++s++{endsb}++://++__<host>__{startsb}++:++__<port>__{endsb}++/++__<path-to-git-repo>__
     -+- s:["ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>"]
     -+- s:["git://<host>[:<port>]/<path-to-git-repo>"]
     -+- s:["http[s]://<host>[:<port>]/<path-to-git-repo>"]
     -+- s:["ftp[s]://<host>[:<port>]/<path-to-git-repo>"]
     ++- `ssh://[<user>@]<host>[:<port>]/<path-to-git-repo>`
     ++- `git://<host>[:<port>]/<path-to-git-repo>`
     ++- `http[s]://<host>[:<port>]/<path-to-git-repo>`
     ++- `ftp[s]://<host>[:<port>]/<path-to-git-repo>`
       
       An alternative scp-like syntax may also be used with the ssh protocol:
       
      -- {startsb}__<user>__++@++{endsb}__<host>__++:/++__<path-to-git-repo>__
     -+- s:["[<user>@]<host>:/<path-to-git-repo>"]
     ++- `[<user>@]<host>:/<path-to-git-repo>`
       
       This syntax is only recognized if there are no slashes before the
       first colon. This helps differentiate a local path that contains a
     @@ Documentation/urls.txt: colon. For example the local path `foo:bar` could be spe
       url.
       
      -The ssh and git protocols additionally support ++~++__<username>__ expansion:
     -+The ssh and git protocols additionally support s:["~<username>"] expansion:
     ++The ssh and git protocols additionally support `~<username>` expansion:
       
      -- ++ssh://++{startsb}__<user>__++@++{endsb}__<host>__{startsb}++:++__<port>__{endsb}++/~++__<user>__++/++__<path-to-git-repo>__
      -- ++git://++__<host>__{startsb}++:++__<port>__{endsb}++/~++__<user>__++/++__<path-to-git-repo>__
      -- {startsb}__<user>__++@++{endsb}__<host>__++:~++__<user>__++/++__<path-to-git-repo>__
     -+- s:["ssh://[<user>@]<host>[:<port>]/~<user>/<path-to-git-repo>"]
     -+- s:["git://<host>[:<port>]/~<user>/<path-to-git-repo>"]
     -+- s:["[<user>@]<host>:~<user>/<path-to-git-repo>"]
     ++- `ssh://[<user>@]<host>[:<port>]/~<user>/<path-to-git-repo>`
     ++- `git://<host>[:<port>]/~<user>/<path-to-git-repo>`
     ++- `[<user>@]<host>:~<user>/<path-to-git-repo>`
       
       For local repositories, also supported by Git natively, the following
       syntaxes may be used:
     @@ Documentation/urls.txt: endif::git-clone[]
       
       When Git doesn't know how to handle a certain transport protocol, it
      -attempts to use the `remote-`{empty}__<transport>__ remote helper, if one
     -+attempts to use the s:["remote-<transport>"] remote helper, if one
     ++attempts to use the `remote-<transport>` remote helper, if one
       exists. To explicitly request a remote helper, the following syntax
       may be used:
       
      -- _<transport>_::__<address>__
     -+- s:["<transport>::<address>"]
     ++- `<transport>::<address>`
       
       where _<address>_ may be a path, a server and path, or an arbitrary
       URL-like string recognized by the specific remote helper being

-- 
gitgitgadget
