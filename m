From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Pull request for msysGit patches
Date: Wed, 29 Sep 2010 10:51:17 -0700
Message-ID: <7vhbh8o2ui.fsf@alter.siamese.dyndns.org>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
 <201009282252.25688.j6t@kdbg.org>
 <20100928210837.GA8317@capella.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 19:51:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P10oj-0007PP-H1
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 19:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668Ab0I2Rvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 13:51:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab0I2Rvg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 13:51:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BC340DA6C9;
	Wed, 29 Sep 2010 13:51:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tKAaRx4YYWwGwOqP9OI+JowE15k=; b=byuaFp
	+0uoiM9HKCwduxYjo0iGzk4ZPN2gA20nCq4OL9sVGcP+xK503cVId9c5Eqh7MYL4
	2e0k53slm71yQZTj0bScJwcZMhXIDqIKHrB8Bwd3fWQxED7Ibmw6oi9FW9Iq+hLt
	fuKYmICyCdfmYsMvh0FRffN733OInWN1pM3nQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wqxvy1pLuVe9ZMe9zn+AzwbAxL5RPNLU
	ind6CCOyQNgfhbtZ6YcJmU+vdUnNIo1kSHgcwRzbhFvgM6P5kRUwv+G5lzkj2Vxq
	lW2SdjpkORWAkxPk/6FvXTtaEnsf81s7IDVEQzw2B4Gg2iEQAlYNJKXA+UTypt2Q
	vyzmFr2xXXE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B209DA6AE;
	Wed, 29 Sep 2010 13:51:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DA10DA6AD; Wed, 29 Sep
 2010 13:51:18 -0400 (EDT)
In-Reply-To: <20100928210837.GA8317@capella.cs.uchicago.edu> (Jonathan
 Nieder's message of "Tue\, 28 Sep 2010 16\:08\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F6FF148-CBF2-11DF-9F48-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157585>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Johannes Sixt wrote:
>> On Dienstag, 28. September 2010, Pat Thoyts wrote:
>
>>> Johannes Schindelin (11):
>>>       Avoid TAGS/tags warning from GNU Make
>>
>> OK.
>
> Wasn't this one reviewed on-list recently?

Yeah, I remember it vaguely ;-)

Although I do not care very much either way, this probably is a better
approach, I think, if there are people on MinGW and/or OS/X who use
tags/etags.

Will queue.

> -- 8< --
> From: Junio C Hamano <gitster@pobox.com>
> Subject: MinGW: avoid collisions between "tags" and "TAGS"
>
> On case insensitive filesystems, "tags" and "TAGS" target will try to
> overwrite the same file.  Allow MinGW to use "ETAGS" instead.
>
> These two targets do produce real files; do not put them on .PHONY target
> list.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  Makefile |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index b7a62cf..d3dcfb1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -390,6 +390,8 @@ SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
>  	  $(patsubst %.py,%,$(SCRIPT_PYTHON)) \
>  	  git-instaweb
>  
> +ETAGS_TARGET = TAGS
> +
>  # Empty...
>  EXTRA_PROGRAMS =
>  
> @@ -1122,6 +1124,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>  	NO_REGEX = YesPlease
>  	NO_PYTHON = YesPlease
>  	BLK_SHA1 = YesPlease
> +	ETAGS_TARGET = ETAGS
>  	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/fnmatch -Icompat/win32
>  	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>  	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/winansi.o \
> @@ -1961,11 +1964,11 @@ info:
>  pdf:
>  	$(MAKE) -C Documentation pdf
>  
> -TAGS:
> -	$(RM) TAGS
> -	$(FIND) . -name '*.[hcS]' -print | xargs etags -a
> +$(ETAGS_TARGET): FORCE
> +	$(RM) $(ETAGS_TARGET)
> +	$(FIND) . -name '*.[hcS]' -print | xargs etags -a -o $(ETAGS_TARGET)
>  
> -tags:
> +tags: FORCE
>  	$(RM) tags
>  	$(FIND) . -name '*.[hcS]' -print | xargs ctags -a
>  
> @@ -2235,7 +2238,7 @@ clean:
>  	$(RM) $(TEST_PROGRAMS)
>  	$(RM) -r bin-wrappers
>  	$(RM) -r $(dep_dirs)
> -	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h TAGS tags cscope*
> +	$(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
>  	$(RM) -r autom4te.cache
>  	$(RM) config.log config.mak.autogen config.mak.append config.status config.cache
>  	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
> @@ -2259,7 +2262,7 @@ endif
>  
>  .PHONY: all install clean strip
>  .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
> -.PHONY: FORCE TAGS tags cscope
> +.PHONY: FORCE cscope
>  
>  ### Check documentation
>  #
> -- 
> 1.7.3.1.gd86b1
