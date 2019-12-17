Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F3C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19C92082E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 18:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WdPO2mZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfLQSi5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:38:57 -0500
Received: from mout.gmx.net ([212.227.17.22]:54879 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfLQSi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 13:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576607932;
        bh=1nGwng3rMkqxdJ1k4VqRU7zD9S015VjEXRd7YNNoQpc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WdPO2mZgKLUdyAWb/5+vciAPTucad1bctXdYP4m5gf/bqBss37VbnU9PXRRXSZ1ET
         WXtFuRcvUFJK2+bI9vl+Y/+eJk7dMKt/L7koLym9AdRwwE+1optIL9JQV//un7L6PA
         ZB8FJYg8CF5jKUWvIfR6rd+tqFUl87ylrKODj8uM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fIQ-1ibGOU2A8I-007A6R; Tue, 17
 Dec 2019 19:38:52 +0100
Date:   Tue, 17 Dec 2019 19:38:37 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v4 09/15] bugreport: generate config safelist based on
 docs
In-Reply-To: <20191213004312.169753-10-emilyshaffer@google.com>
Message-ID: <nycvar.QRO.7.76.6.1912171936450.46@tvgsbejvaqbjf.bet>
References: <20191213004312.169753-1-emilyshaffer@google.com> <20191213004312.169753-10-emilyshaffer@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PoaoMGVin+rC2Dfc7Wl+wVAYbPAaEMrasw94HV/NI+eFmLLlRXw
 Q+YZHk2XqkElXc+VIpVE+464/g7E4feOYAY01QWPwIa6oUCtWO6Z+Lg72nUKefyZCCTP3jJ
 4MXZ1/d1dJdNZG0JLwzyg9bPn7vQ9+JPhoxgS1DzrqbO8707UD/wZwhMz48qeQzw1F+xaQm
 07Z4besiJ/TXBEBDMYPAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i9PvCgfHOBI=:kpVuTnJTmHxLvKVgnOnKZw
 TuSu2B25TLu+mvmI8TzFsoWT+nxE0IHiYFiyPNmcHa8ifPqskHHXM5M/gQNLcIX7Pf58WfsZs
 oZsgsgGOH3GceApwRLHRZbrwpp53w10kNoiGPAxhL9rE1U9CEJ0iFlVW/ln0MFmup1UdW82DU
 i7wrjISEyrFJpCWbysV3F+2kedZV73j7I+nIxRCdqLubppDCrNP3iS8VI9YqsBEDAhrXzVo5Y
 09cHUQdQyvM9DA1A7IDXd8FL+fqPPldEQD1AX3SvNgfGFE/g/aLarqxTKjklrAynM9gXGzuCK
 Nf/QuXnwvY6dOXuLjpvXRfkreX0I5eRiHU5GWF/62gqclWUZ1p7pH9JtRBLxgkputlcyw1YK5
 OJYlpg9m/5mzPJYI8Lg/JXTd2r9qHDgJgJq1PMWZLdrtXC5jU9MV2JtkoDv8vLRaGcOcC1grk
 6zrpIJQYcMCzfnqm6YBItVRnq80QNl8bBVMGFwwBHDiWJQh2pE6UQiMvqPL0BHqqtoArUkUjF
 N+T5fFLdiYOAFKWrN8OCtb4muAXIWo//pwWomdJA8khxEh1WMdyY0yMiUF3oc0ddqkTaXKmkc
 ht+WF8zbqnspgF/v56TqwdGOXj3sfH3SAp22MCmqkzqr+Fiyr6oc7THz8aIKtnec/9j36YzVa
 33cNIyKN+kN2QzoVOCszhn57RQhSZfEZ8JFKYb5h886W8AZbO8rIKrzIsEZ3g3TjN2o4DiH0u
 9OHZ3ZcEi0PnDXtgS0GCdY70TYtjEsFS8Xc0aVdf6Hd00hAdBLfG+9uTHyIEkntSYfSRGUyPH
 6/RgWG05QKXlPz/JfFdhozQ0z8tFkZJkRV/nTNpmVcQuY7xyIjVnW2T2D01Z2KqsGL5afj6Si
 YX06oyXtVR91hiWO89ZU6mrSJF7W0DzfcOinjWokUMfv/1h8anycLYWP8xqmKz69SkG++6WII
 oqRzYX7UYHr2DvttzvzODbErJWf97kBbqaRB6dz+rzQBXRfpFgz/RTQUsYk4xlRwx8lcGXEJd
 HHxGfERorXyaGbHErcVM6p0/EWHzLxXsSxzU//bshCUm5sczqdbRkV3M1dcNHm2qd0M0oTTU+
 wwUJdl7Bf7C5QA9F/zyChL7i01T0MriW6nH+z0KuQ5/0mHUyezxiKO73l0flDyFKziKWU9xUd
 KWr2bQaonyKPlo5I+PlOK8O1cBCGT5mVfIGtne0QeztqA0K0Rsl4/MLtvd3zOY+a3VfrD4Dkr
 1prIO2HaNhzDEKkSAdw8fxgbPKad6em3r6FIB/unjPK7HgC3mvMfIhSHIkZs=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Thu, 12 Dec 2019, Emily Shaffer wrote:

> diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asc=
iidoctor-extensions.rb
> index d906a00803..750bdff9af 100644
> --- a/Documentation/asciidoctor-extensions.rb
> +++ b/Documentation/asciidoctor-extensions.rb
> @@ -37,6 +37,10 @@ module Git
>            output =3D output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
>          end
>          output
> +
> +    class BugReportProcessor < Asciidoctor::Extensions::InlineMacroProc=
essor
> +      def process(parent, action, attrs)
> +        ""

The Azure Pipeline fails on this hunk, saying:

/usr/bin/asciidoctor: /home/vsts/work/1/s/Documentation/asciidoctor-extens=
ions.rb:41: class definition in method body (SyntaxError)
/home/vsts/work/1/s/Documentation/asciidoctor-extensions.rb:55: syntax err=
or, unexpected end-of-input, expecting keyword_end

See
https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D23830&view=
=3Dlogs&jobId=3D253e5128-1058-5bd4-fdf1-9b556d3207f8&j=3D253e5128-1058-5bd=
4-fdf1-9b556d3207f8&t=3D95c65aec-3627-54dc-fc17-47625f123bb3
for details.

Ciao,
Dscho

>        end
>      end
>    end
> @@ -45,4 +49,7 @@ end
>  Asciidoctor::Extensions.register do
>    inline_macro Git::Documentation::LinkGitProcessor, :linkgit
>    postprocessor Git::Documentation::DocumentPostProcessor
> +  # The bugreport macro does nothing as far as rendering is
> +  # concerned -- we just grep for it in the sources.
> +  inline_macro Git::Documentation::BugReportProcessor, :bugreport
>  end
> diff --git a/Documentation/config/sendemail.txt b/Documentation/config/s=
endemail.txt
> index 0006faf800..92f5082013 100644
> --- a/Documentation/config/sendemail.txt
> +++ b/Documentation/config/sendemail.txt
> @@ -1,63 +1,63 @@
> -sendemail.identity::
> +sendemail.identity bugreport:exclude[x] ::
>  	A configuration identity. When given, causes values in the
>  	'sendemail.<identity>' subsection to take precedence over
>  	values in the 'sendemail' section. The default identity is
>  	the value of `sendemail.identity`.
>
> -sendemail.smtpEncryption::
> +sendemail.smtpEncryption bugreport:include[x] ::
>  	See linkgit:git-send-email[1] for description.  Note that this
>  	setting is not subject to the 'identity' mechanism.
>
> -sendemail.smtpssl (deprecated)::
> +sendemail.smtpssl (deprecated) bugreport:exclude[x] ::
>  	Deprecated alias for 'sendemail.smtpEncryption =3D ssl'.
>
> -sendemail.smtpsslcertpath::
> +sendemail.smtpsslcertpath bugreport:exclude[x] ::
>  	Path to ca-certificates (either a directory or a single file).
>  	Set it to an empty string to disable certificate verification.
>
> -sendemail.<identity>.*::
> +sendemail.<identity>.* bugreport:exclude[x] ::
>  	Identity-specific versions of the 'sendemail.*' parameters
>  	found below, taking precedence over those when this
>  	identity is selected, through either the command-line or
>  	`sendemail.identity`.
>
> -sendemail.aliasesFile::
> -sendemail.aliasFileType::
> -sendemail.annotate::
> -sendemail.bcc::
> -sendemail.cc::
> -sendemail.ccCmd::
> -sendemail.chainReplyTo::
> -sendemail.confirm::
> -sendemail.envelopeSender::
> -sendemail.from::
> -sendemail.multiEdit::
> -sendemail.signedoffbycc::
> -sendemail.smtpPass::
> -sendemail.suppresscc::
> -sendemail.suppressFrom::
> -sendemail.to::
> -sendemail.tocmd::
> -sendemail.smtpDomain::
> -sendemail.smtpServer::
> -sendemail.smtpServerPort::
> -sendemail.smtpServerOption::
> -sendemail.smtpUser::
> -sendemail.thread::
> -sendemail.transferEncoding::
> -sendemail.validate::
> -sendemail.xmailer::
> +sendemail.aliasesFile bugreport:exclude[x] ::
> +sendemail.aliasFileType bugreport:exclude[x] ::
> +sendemail.annotate bugreport:include[x] ::
> +sendemail.bcc bugreport:include[x] ::
> +sendemail.cc bugreport:include[x] ::
> +sendemail.ccCmd bugreport:include[x] ::
> +sendemail.chainReplyTo bugreport:include[x] ::
> +sendemail.confirm bugreport:include[x] ::
> +sendemail.envelopeSender bugreport:include[x] ::
> +sendemail.from bugreport:include[x] ::
> +sendemail.multiEdit bugreport:include[x] ::
> +sendemail.signedoffbycc bugreport:include[x] ::
> +sendemail.smtpPass bugreport:exclude[x] ::
> +sendemail.suppresscc bugreport:include[x] ::
> +sendemail.suppressFrom bugreport:include[x] ::
> +sendemail.to bugreport:include[x] ::
> +sendemail.tocmd bugreport:include[x] ::
> +sendemail.smtpDomain bugreport:include[x] ::
> +sendemail.smtpServer bugreport:include[x] ::
> +sendemail.smtpServerPort bugreport:include[x] ::
> +sendemail.smtpServerOption bugreport:include[x] ::
> +sendemail.smtpUser bugreport:exclude[x] ::
> +sendemail.thread bugreport:include[x] ::
> +sendemail.transferEncoding bugreport:include[x] ::
> +sendemail.validate bugreport:include[x] ::
> +sendemail.xmailer bugreport:include[x] ::
>  	See linkgit:git-send-email[1] for description.
>
> -sendemail.signedoffcc (deprecated)::
> +sendemail.signedoffcc (deprecated) bugreport:exclude[x] ::
>  	Deprecated alias for `sendemail.signedoffbycc`.
>
> -sendemail.smtpBatchSize::
> +sendemail.smtpBatchSize bugreport:include[x] ::
>  	Number of messages to be sent per connection, after that a relogin
>  	will happen.  If the value is 0 or undefined, send all messages in
>  	one connection.
>  	See also the `--batch-size` option of linkgit:git-send-email[1].
>
> -sendemail.smtpReloginDelay::
> +sendemail.smtpReloginDelay bugreport:include[x] ::
>  	Seconds wait before reconnecting to smtp server.
>  	See also the `--relogin-delay` option of linkgit:git-send-email[1].
> diff --git a/Makefile b/Makefile
> index c49f55a521..76dc51e2b1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -651,7 +651,7 @@ install-perl-script: $(SCRIPT_PERL_GEN)
>  install-python-script: $(SCRIPT_PYTHON_GEN)
>  	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>
> -.PHONY: clean-perl-script clean-sh-script clean-python-script
> +.PHONY: clean-perl-script clean-sh-script clean-python-script clean-scr=
ipt-dependencies
>  clean-sh-script:
>  	$(RM) $(SCRIPT_SH_GEN)
>  clean-perl-script:
> @@ -817,6 +817,7 @@ VCSSVN_LIB =3D vcs-svn/lib.a
>
>  GENERATED_H +=3D config-list.h
>  GENERATED_H +=3D command-list.h
> +GENERATED_H +=3D bugreport-config-safelist.h
>
>  LIB_H :=3D $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':=
!Documentation/' 2>/dev/null || \
>  	$(FIND) . \
> @@ -2161,6 +2162,12 @@ command-list.h: $(wildcard Documentation/git*.txt=
) Documentation/*config.txt Doc
>  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
>  		command-list.txt >$@+ && mv $@+ $@
>
> +bugreport-config-safelist.h: generate-bugreport-config-safelist.sh
> +
> +bugreport-config-safelist.h: Documentation/config/*.txt
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-bugreport-config-safelist.sh \
> +		>$@+ && mv $@+ $@
> +
>  SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
>  	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):=
\
>  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
> @@ -2791,7 +2798,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>
> -GEN_HDRS :=3D config-list.h command-list.h unicode-width.h
> +GEN_HDRS :=3D config-list.h command-list.h unicode-width.h bugreport-co=
nfig-safelist.h
>  EXCEPT_HDRS :=3D $(GEN_HDRS) compat/% xdiff/%
>  ifndef GCRYPT_SHA256
>  	EXCEPT_HDRS +=3D sha256/gcrypt.h
> @@ -3117,7 +3124,8 @@ clean: profile-clean coverage-clean cocciclean
>  	$(RM) $(HCC)
>  	$(RM) -r bin-wrappers $(dep_dirs)
>  	$(RM) -r po/build/
> -	$(RM) *.pyc *.pyo */*.pyc */*.pyo config-list.h command-list.h
> +	$(RM) *.pyc *.pyo */*.pyc */*.pyo
> +	$(RM) config-list.h command-list.h bugreport-config-safelist.h
>  	$(RM) $(ETAGS_TARGET) tags cscope*
>  	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
>  	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
> diff --git a/generate-bugreport-config-safelist.sh b/generate-bugreport-=
config-safelist.sh
> new file mode 100755
> index 0000000000..06b8e0c3c4
> --- /dev/null
> +++ b/generate-bugreport-config-safelist.sh
> @@ -0,0 +1,22 @@
> +#!/bin/sh
> +
> +cat <<EOF
> +/* Automatically generated by bugreport-generate-config-safelist.sh */
> +
> +
> +static const char *bugreport_config_safelist[] =3D {
> +EOF
> +
> +# cat all regular files in Documentation/config
> +find Documentation/config -type f -exec cat {} \; |
> +# print the command name which matches the bugreport-include macro
> +sed -n 's/^\(.*\) \+bugreport:include.* ::$/\1/p' |
> +sort |
> +while read line
> +do
> +	echo "	\"$line\","
> +done
> +
> +cat <<EOF
> +};
> +EOF
> --
> 2.24.1.735.g03f4e72817-goog
>
>
>
