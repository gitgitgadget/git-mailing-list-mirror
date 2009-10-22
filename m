From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2009, #04; Wed, 21)
Date: Thu, 22 Oct 2009 01:46:50 -0700 (PDT)
Message-ID: <m3ljj3es02.fsf@localhost.localdomain>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Mark Rada <marada@uwaterloo.ca>,
	Stephen Boyd <bebarino@gmail.com>,
	Nick Edelen <sirnot@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 10:47:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0tK0-0006iu-U5
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 10:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbZJVIqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 04:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbZJVIqu
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 04:46:50 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33504 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZJVIqs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 04:46:48 -0400
Received: by fxm18 with SMTP id 18so8882209fxm.37
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 01:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=oS4FK451ZbSmzfy7KGAtp0qxhJOr9bpGNiZ0MDw/UW4=;
        b=oeWzcOCR9H6Fx+6h8FQ3tiK+3ltEA7N8yLHcarSIiATxg6ChrpXjiHkkgB7Xh3NY2j
         cauDOli82zvteNf0WWP8nuZ0QJwzbVN6T2SgNEa4fqkjBFoPgNjxRBK5slfqlNVNsw4S
         3oB5+lnmESqifxoyqmsKRO9fjgrUauyhte8fc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BGXxFbC5jjeoJnXpoi+DdTx2rxp47YtXqipOlbjrspgD++IonxeUtSVlZrkbIuLTnk
         LTypJ5yBNUypnUxlIqvbam48bsRe/Q2fpJXw1dO+VFTb/bApBncMuM7ql7rKnAJnc0j9
         MOX29+F+Mqe/mQb5E1sfiZtHPgK38FyFNfli4=
Received: by 10.103.87.26 with SMTP id p26mr4043676mul.44.1256201212074;
        Thu, 22 Oct 2009 01:46:52 -0700 (PDT)
Received: from localhost.localdomain (abvj67.neoplus.adsl.tpnet.pl [83.8.207.67])
        by mx.google.com with ESMTPS id j2sm1080618mue.46.2009.10.22.01.46.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Oct 2009 01:46:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9M8k5da012943;
	Thu, 22 Oct 2009 10:46:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9M8jnfu012933;
	Thu, 22 Oct 2009 10:45:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7veiovly35.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131010>

Junio C Hamano <gitster@pobox.com> writes:

> * gb/maint-gitweb-esc-param (2009-10-13) 1 commit.
>   (merged to 'next' on 2009-10-14 at 105f997)
>  + gitweb: fix esc_param
>  (this branch is used by sb/gitweb-link-author.)

Good.  Beside fixing excaping of multibyte Unicode characters this
also finally makes gitweb use '+' and not '%20' to encode space ' '
in CGI parameters.

This reminds me that gitweb really should do conversion / marking data
as UTF-8 _on input_, to avoid situations where output is mangled
because of problems with Unicode.  That goes to my gitweb's TODO.

> * mr/gitweb-snapshot (2009-09-26) 2 commits.
>  - gitweb: append short hash ids to snapshot files
>   (merged to 'next' on 2009-10-11 at 22ba047)
>  + gitweb: check given hash before trying to create snapshot
> 
> I lost track of the discussion around the tip commit.  The bottom one may
> better go to 'master' regardless.

The tip commit should be fixed before accepting.  There are some
problems with it as it is now:

 * $hash parameter is abused to hold version suffix of snapshot
   filename (and archive prefix), e.g. 'next-ae4ab03'; it really
   should be done using separate variable, and perhaps even separate
   subroutine which would generate snapshot name.

 * I don't think it works with fully qualified refnames that gitweb
   itself generate, e.g. 'refs/heads/next' or 'refs/tags/v1.6.0',
   nor with hierarchical branch names such as 'mr/gitweb-snapshot';
   snapshot name can't include '/', and prefix shouldn't include '/'
 
 * when new test is running with --debug option, it dumps whole output
   of gitweb for 'snapshot' action, which includes *binary data*, and
   not only HTTP headers like it should (at least in first version).

> * sb/gitweb-link-author (2009-10-15) 1 commit
>  - gitweb: linkify author/committer names with search
> 
> Soon in 'next'.

Is this version that uses title attribute to show that this link is
different in that it leads to search results, not an action view?

> * jn/gitweb-blame (2009-09-01) 5 commits.
>  - gitweb: Minify gitweb.js if JSMIN is defined
>  - gitweb: Create links leading to 'blame_incremental' using JavaScript
>   (merged to 'next' on 2009-10-11 at 73c4a83)
>  + gitweb: Colorize 'blame_incremental' view during processing
>  + gitweb: Incremental blame (using JavaScript)
>  + gitweb: Add optional "time to generate page" info in footer
> 
> Ajax-y blame.  Probably the first three should go to 'master' by now?

The first three makes fairly 'invisible' change, but introduce
possibility of using JavaScript in gitweb.  I'd like more testing with
different browsers than mine, but corrections if any can be done
in-tree.

The "Create links" patch is not ready yet.


> * rs/pretty-wrap (2009-10-17) 1 commit
>  - Implement wrap format %w() as if it is a mode switch
>  (this branch uses js/log-rewrap; is related to jc/strbuf-nested-expand.)
> 
> When it comes to design issues to keep unnecessary complexity out, I tend
> to trust Rene (and Nico) a lot more than I trust myself.  Tonight's 'pu'
> queues this series instead of my "nested" one.

> * jc/strbuf-nested-expand (2009-10-18) 3 commits
>  . Teach --wrap to only indent without wrapping
>  . Add %[wrap(width,in1,in2)<<any-string>>%] implementation
>  . strbuf_nested_expand(): allow expansion to interrupt in the middle
>  (this branch uses js/log-rewrap; is related to rs/pretty-wrap.)
> 
> Ejected from 'pu' to let rs/pretty-wrap in as described above.

I think nested expand is easier to use than a mode switch: using
scoping (well, kind of) like in high-level programming languages is
IMVHO easier than programming a state machine like in assembler (or
e.g. OpenGL).

On the other hand this makes pretty format into a mini-language; also
we already have and use mode switches in the form of color codes.
Perhaps if color also used wrapping / nested expand, so one doesn't
have to track where to turn off and on which toggle...

> * jg/log-format-body-indent (2009-09-19) 1 commit.
>  . git-log --format: Add %B tag with %B(x) option

...and this was yet another alternate solution (less generic, though)


> * jc/pretty-lf (2009-10-04) 1 commit.
>  - Pretty-format: %[+-]x to tweak inter-item newlines

I understand that %a%+b expands to %a%n%b if %b has non-empty
expansion, and to %a if %b is empty, but what %-b is used for?

> * js/log-rewrap (2008-11-10) 2 commits
>  - Add strbuf_add_wrapped_text() to utf8.[ch]
>  - print_wrapped_text(): allow hard newlines
>  (this branch is used by jc/strbuf-nested-expand and rs/pretty-wrap.)
> 
> Soon in 'next'; regardless of how wrapping is exposed to --pretty=format,
> this code will be used, and it seems to be leak-free and reasonably done.
> 
> We _might_ want to cherry-pick the tip of jc/strbuf-nested-expand to this
> series, though.
 


 
> --------------------------------------------------
> [Cooking]
> 
> * ne/rev-cache (2009-10-19) 7 commits.
>  - support for commit grafts, slight change to general mechanism
>  - support for path name caching in rev-cache
>  - full integration of rev-cache into git, completed test suite
>  - administrative functions for rev-cache, start of integration into git
>  - support for non-commit object caching in rev-cache
>  - basic revision cache system, no integration or features
>  - man page and technical discussion for rev-cache
> 
> Still unstable?  Has an extra test squashed in; tonight's 'pu' does not
> pass tests.

BTW. I would really prefer if this series was send with cover letter
explaining series and perhaps differences from previous version of
series as a whole (reordering, splitting and joining patches, new
patches etc.), and individual patches in series replies to this cover
letter, without 'Re: ' prefix in subject, and with explanation of the
difference from previous version (if any) in the commentary area.


> * nd/sparse (2009-08-20) 19 commits.
>  - sparse checkout: inhibit empty worktree
>  - Add tests for sparse checkout
>  - read-tree: add --no-sparse-checkout to disable sparse checkout support
>  - unpack-trees(): ignore worktree check outside checkout area
>  - unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
>  - unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
>  - unpack-trees.c: generalize verify_* functions
>  - unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
>  - Introduce "sparse checkout"
>  - dir.c: export excluded_1() and add_excludes_from_file_1()
>  - excluded_1(): support exclude files in index
>  - unpack-trees(): carry skip-worktree bit over in merged_entry()
>  - Read .gitignore from index if it is skip-worktree
>  - Avoid writing to buffer in add_excludes_from_file_1()
>  - Teach Git to respect skip-worktree bit (writing part)
>  - Teach Git to respect skip-worktree bit (reading part)
>  - Introduce "skip-worktree" bit in index, teach Git to get/set this bit
>  - Add test-index-version
>  - update-index: refactor mark_valid() in preparation for new options

Hmmm... what is happening with that series?
 
-- 
Jakub Narebski
Poland
ShadeHawk on #git
