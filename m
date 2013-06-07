From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] build: generate test scripts
Date: Fri, 7 Jun 2013 17:43:43 -0500
Message-ID: <CAMP44s3doQe2PTGSbZ7Afi9DNDGstN4VJAompeLxUjn4Cg=g2Q@mail.gmail.com>
References: <1370642587-32352-1-git-send-email-felipe.contreras@gmail.com>
	<1370642587-32352-2-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s1t7aqOorQqhXekZ5+DSZc8vjw+pP_bjLxki9F3bo5q1Q@mail.gmail.com>
	<7v1u8dsghd.fsf@alter.siamese.dyndns.org>
	<CAMP44s2N7AjpyK325FK5zWMnO4oausF3xiNmcfoqvNtxJ7DUEg@mail.gmail.com>
	<7vtxl9r1df.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 00:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul5Nu-00009W-OU
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094Ab3FGWnp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:43:45 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:51828 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab3FGWnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:43:45 -0400
Received: by mail-lb0-f170.google.com with SMTP id t11so4770246lbd.15
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=f+Husc+XhdZhr4yARaY1VKgMwB5ZoSh0UGb/73StBDw=;
        b=tVe5iQOpaN/vMSSg7zkh10+n0NSNCz65MOpuQ0bpJ+gGoDqAohoRbeWyDrsq2oj2UU
         BXgHa73zll03DbqOXQhgjBL85r3iZ7n+scPLhzn4Qrc1UirdK43SQvOQIQocpUWY6zZs
         uAMbLYAMM17Ht9o+PUfxCXp/wQm0He7sJ0LVh+t7KqtbttJq47duG/GPb7jNgbXXgiXx
         fJKPLo/GgX8rCV4HlyipwujUSaSbagfTPB8jwkqEZ6mIm9KieF7JoKfrfoMCjd31zjCM
         soraMPuGQzWAGqEKRI/aSbkqZ6leOUsQsmcLrWROX5mRU0I+6lv4StFUe1A8bfT7AYuN
         +N6g==
X-Received: by 10.112.157.226 with SMTP id wp2mr2088906lbb.65.1370645023581;
 Fri, 07 Jun 2013 15:43:43 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 15:43:43 -0700 (PDT)
In-Reply-To: <7vtxl9r1df.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226761>

On Fri, Jun 7, 2013 at 5:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Perhaps like this?
>>>
>>>  Makefile | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Makefile b/Makefile
>>> index a748133..03fda50 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -2239,6 +2239,7 @@ endif
>>>
>>>  test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
>>>
>>> +all:: $(NO_INSTALL)
>>>  all:: $(TEST_PROGRAMS) $(test_bindir_programs)
>>>
>>>  bin-wrappers/%: wrap-for-bin.sh
>>> @@ -2489,7 +2490,7 @@ clean: profile-clean coverage-clean
>>>         $(RM) *.o *.res block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
>>>                 builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
>>>         $(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
>>> -       $(RM) $(TEST_PROGRAMS)
>>> +       $(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
>>>         $(RM) -r bin-wrappers $(dep_dirs)
>>>         $(RM) -r po/build/
>>>         $(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
>>
>> Looks good to me.
>
> Actually the above would not work well.  This is because...
>
>>> ..., assuming that NO_INSTALL will mean "We always
>>> want to build these, but we never do not want to install them"
>>> forever (which I am OK to assume).
>
> ... the assumption does *not* hold already with git-remote-testgit,
> which is (or will be with patch 2/2) NO_INSTALL and we do not want
> to install it, but it is not built, hence we do not want to remove
> it, either.

It is generated, in next. If it's not generated, there's no need to
add it to NO_INSTALL.

-- 
Felipe Contreras
