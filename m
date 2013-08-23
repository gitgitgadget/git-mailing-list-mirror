From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: t3010 broken by 2eac2a4
Date: Fri, 23 Aug 2013 00:32:26 -0400
Message-ID: <CAPig+cR0Z0gghUH5C6+XCuGQ3gz5JoWrnObVbbA5_ahPmC8G2Q@mail.gmail.com>
References: <82078845-3AB9-4B36-9130-039CC33C8A7A@gernhardtsoftware.com>
	<xmqqbo4qu3g4.fsf@gitster.dls.corp.google.com>
	<CAPig+cQHTvmTWvGfg1Z3KfBrPD+QbSEbYBYz6XWT3KKu3-+jyQ@mail.gmail.com>
	<xmqqbo4pqvde.fsf@gitster.dls.corp.google.com>
	<CAPig+cQmvRDDc3BHbta_UhCQe9QvbtAm0RJgt6HbtgFAKgo0Vg@mail.gmail.com>
	<xmqq7gfdqumd.fsf@gitster.dls.corp.google.com>
	<CAPig+cSEQLk2M+X5QP7mkm846wqqHRCjPHgO7O3URvNcsYO6+w@mail.gmail.com>
	<xmqq38q1qu3l.fsf@gitster.dls.corp.google.com>
	<CAPig+cSgM-kO0Mk9qbGfLR8DZkYQt60Va4N2wfRBVqmReTPowQ@mail.gmail.com>
	<CAPig+cQ15Qq7pJ0sLmnuQt_EERn9fkzCa-Gr-pb6a_zf1MLcGQ@mail.gmail.com>
	<xmqqwqndpbfc.fsf@gitster.dls.corp.google.com>
	<CAPig+cSqtMOYvxbvXstm9nqQD9sQ378NKCHSK7Ec6GrK5VJiGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 06:32:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCj32-00035M-EZ
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 06:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab3HWEc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 00:32:28 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:36051 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab3HWEc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 00:32:28 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so112263lab.24
        for <git@vger.kernel.org>; Thu, 22 Aug 2013 21:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RoWtzHaZYSytZcsxfXUERv5QzvEnE+zQsVp/fVPD0Wo=;
        b=pArLhYA23LtuxP9TzYizNbsv/m6GBcnMV9oTZHbEPCzik+ZuM3xC8D20H1wUnUdGkl
         V/qTFdvp55hHlNyJ7UKeK+hZI07s3d8nvrS4QzvSftoZqG56ipcDL7UOPd5AGtyU5Uvq
         XJl41EXgwFvrY5VFJ/J1l7gjsrNsPLwfoylpYfuW1n5dVvePt0aBcIjHXxotDaS07B5f
         hKGDF4eRqZzsuiRjAAHY+QT4ih+KkBCwaErhgtt7i5DOt7/WQzr2IkmSa8BCwVN68kv2
         PTyYtj1IitgwIGFrxD2QYN8CxukEGhdSN99l07RnXjz4wvTQb47aLzdjN8DoWRvlZSBk
         Ui7w==
X-Received: by 10.152.116.109 with SMTP id jv13mr290646lab.30.1377232346660;
 Thu, 22 Aug 2013 21:32:26 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Thu, 22 Aug 2013 21:32:26 -0700 (PDT)
In-Reply-To: <CAPig+cSqtMOYvxbvXstm9nqQD9sQ378NKCHSK7Ec6GrK5VJiGA@mail.gmail.com>
X-Google-Sender-Auth: QxE4aBR_yXRd9tgYCzSe7i3N-sE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232799>

On Thu, Aug 22, 2013 at 7:15 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Aug 22, 2013 at 7:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> Status update: For the 'pathx' directory created by the t3010 test,
>>> directory_exists_in_index() returns false on OSX, but true is returned
>>> on Linux.
>>
>> Because a regular pathx/ju is in the index at that point, the
>> correct answer directory_exists_in_index() should give for 'pathx'
>> is "index_directory", not "index_nonexistent", I think.
>
> directory_exists_in_index() and directory_exists_in_index_icase() are
> behaving differently. You can replicate the problem on Linux by
> enabling core.ignorecase in the test (sans gmail whitespace damage):
>
> -->8--
> diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modif
> index 3120efd..8c76160 100755
> --- a/t/t3010-ls-files-killed-modified.sh
> +++ b/t/t3010-ls-files-killed-modified.sh
> @@ -89,7 +89,7 @@ test_expect_success 'git ls-files -k to show killed files.' '
>         : >path9 &&
>         touch path10 &&
>         >pathx/ju/nk &&
> -       git ls-files -k >.output
> +       git -c core.ignorecase=true ls-files -k >.output
>  '
> -->8--

I sent a patch [1] which resolves the problem, although the solution
is not especially pretty (due to some ugliness in the existing
implementation).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/232796
