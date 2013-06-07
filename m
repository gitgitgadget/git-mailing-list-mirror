From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] build: generate test scripts
Date: Fri, 07 Jun 2013 15:40:12 -0700
Message-ID: <7vtxl9r1df.fsf@alter.siamese.dyndns.org>
References: <1370642587-32352-1-git-send-email-felipe.contreras@gmail.com>
	<1370642587-32352-2-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s1t7aqOorQqhXekZ5+DSZc8vjw+pP_bjLxki9F3bo5q1Q@mail.gmail.com>
	<7v1u8dsghd.fsf@alter.siamese.dyndns.org>
	<CAMP44s2N7AjpyK325FK5zWMnO4oausF3xiNmcfoqvNtxJ7DUEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 00:40:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul5Kc-0005hi-KX
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756665Ab3FGWkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:40:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755822Ab3FGWkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:40:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66A1C2616A;
	Fri,  7 Jun 2013 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8yDtIhZYpX36pEbjKFq70p4x+2I=; b=iFVnF+
	/HxstohW/3O2Hcu9H5TCioGbgXQJXyI3oq5VUMg9ka7WSBxCo9h4+fH5jtmZQuHH
	HvfKGI8mLphEn5KYdKEZ3Kedds2+TFCaVumj3jj9Y6aivxm4XuTwA9C+cvQvZolp
	iKw/edg8OTWZ1KzF6Dca5nrrcdPok0C93MOoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y0QBtjcgYERm0eJHBuKMkrJuf6IVIi1U
	SqTNyJi32U+6Am3/cDmLm0U6ssnCulybV6+8OI2fT3Ido3MZnmaqT8KemNycm2Uv
	3rueDVXCmJsr7JYvJYAreTo8o3/hgPs5OTs2C+dEv26sRshKfuXGdf/vOkuvrt2v
	mGsNrPeqtJ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57AD126169;
	Fri,  7 Jun 2013 22:40:19 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 00D9026160;
	Fri,  7 Jun 2013 22:40:13 +0000 (UTC)
In-Reply-To: <CAMP44s2N7AjpyK325FK5zWMnO4oausF3xiNmcfoqvNtxJ7DUEg@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 7 Jun 2013 17:33:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38078460-CFC3-11E2-984C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226760>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Perhaps like this?
>>
>>  Makefile | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index a748133..03fda50 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2239,6 +2239,7 @@ endif
>>
>>  test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
>>
>> +all:: $(NO_INSTALL)
>>  all:: $(TEST_PROGRAMS) $(test_bindir_programs)
>>
>>  bin-wrappers/%: wrap-for-bin.sh
>> @@ -2489,7 +2490,7 @@ clean: profile-clean coverage-clean
>>         $(RM) *.o *.res block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
>>                 builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
>>         $(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
>> -       $(RM) $(TEST_PROGRAMS)
>> +       $(RM) $(TEST_PROGRAMS) $(NO_INSTALL)
>>         $(RM) -r bin-wrappers $(dep_dirs)
>>         $(RM) -r po/build/
>>         $(RM) *.spec *.pyc *.pyo */*.pyc */*.pyo common-cmds.h $(ETAGS_TARGET) tags cscope*
>
> Looks good to me.

Actually the above would not work well.  This is because...

>> ..., assuming that NO_INSTALL will mean "We always
>> want to build these, but we never do not want to install them"
>> forever (which I am OK to assume).

... the assumption does *not* hold already with git-remote-testgit,
which is (or will be with patch 2/2) NO_INSTALL and we do not want
to install it, but it is not built, hence we do not want to remove
it, either.
