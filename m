From: Rich Midwinter <rich.midwinter@gmail.com>
Subject: Re: [PATCH 0/5] Allow git log to use mailmap file
Date: Tue, 11 Dec 2012 22:41:56 +0000
Message-ID: <CALKB1SXOqYmynv7EgezeL7-epsiB7OnSYKhHyS_u8UWOhJgUsQ@mail.gmail.com>
References: <1355264493-8298-1-git-send-email-apelisse@gmail.com>
	<7vip886wyr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Antoine Pelisse <apelisse@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 23:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiYWl-0000RU-Af
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 23:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754099Ab2LKWl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 17:41:58 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:55378 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab2LKWl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 17:41:57 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so15703pad.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 14:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FLP3mjCJnEi9x9B1XdtOQz5VoMh8MDABwi0DtFJqDVQ=;
        b=YQzok8Ybd2PKkYdlwIzKQ2Nkj9PXLXC6PnLUrF7C2TEEpw6RRa8WFly0N/SSw9VWkX
         fRvTu4+hEMqB0AuIQ79us1MSMOpHeJ4obIF1GA4S/vQVOQdnhxmLxEkeS/VrXW3ap/B4
         cdoJHTD0ieefUqBcYqyPAg9XCbMalM0xZkrVYFpyBQWPdpj/BgFFQM0U8fMXIdCFMVvy
         cUGyHbWzgmqmEbt14lLei3eKljPNJIrQiKArBc+jaTynBnWYRI+6S+cqQXnR8Ceo3e+u
         aAGyN/1hM8mnXVZrLPC0KslEImJ6tb9TEwGtc/vkOXdxWLmfWkyEy2ggcO+Sa/6mvrzZ
         M3cA==
Received: by 10.68.211.42 with SMTP id mz10mr53166085pbc.100.1355265716998;
 Tue, 11 Dec 2012 14:41:56 -0800 (PST)
Received: by 10.68.41.7 with HTTP; Tue, 11 Dec 2012 14:41:56 -0800 (PST)
In-Reply-To: <7vip886wyr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211312>

It certainly was. Thanks for picking this up so quick guys.

On 11 December 2012 22:33, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> Implement the feature suggested here [1] by Rich Mindwinter
>> and Junio C Hamano (and following his advices)
>>
>> This is a pre-version so there are a bunch of things still missing,
>> among them:
>>  - There is no tests
>>  - Grep search for mailmap author/committer is not available
>>  - There is no documentation of the new option
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/211270
>
> That was quick ;-)
>
>> Antoine Pelisse (5):
>>   Use split_ident_line to parse author and committer
>>   mailmap: Remove buffer length limit in map_user
>>   mailmap: Add mailmap structure to rev_info and pp
>>   pretty: Use mailmap to display username and email
>>   log: Add --use-mailmap option
>>
>>  builtin/blame.c | 59 +++++++++++++++++-------------------------------
>>  builtin/log.c   |  9 +++++++-
>>  commit.h        |  1 +
>>  log-tree.c      |  1 +
>>  mailmap.c       | 16 ++++++-------
>>  pretty.c        | 70 ++++++++++++++++++++++++++++++++++++---------------------
>>  revision.h      |  1 +
>>  7 files changed, 84 insertions(+), 73 deletions(-)
>>
>> --
>> 1.8.1.rc1.5.g7e0651a
