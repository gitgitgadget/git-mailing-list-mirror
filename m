From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Suggestion on hashing
Date: Tue, 6 Dec 2011 13:23:00 +0700
Message-ID: <CACsJy8CXkz-W3Z3pX-C-+fjLz=WahBajE2uLEG-f3gG_svEhug@mail.gmail.com>
References: <1322813319.4340.109.camel@yos> <CACsJy8CO1GtpZVo-oA2eKbQadsXYBEKVLfUH0GONR5jovuvH+Q@mail.gmail.com>
 <alpine.DEB.2.00.1112060146121.15104@hoki.goeswhere.com> <CACsJy8CM8xqWxTx14QbY+-bT=306p3U=6gJfRaW=dDD-Swo7-w@mail.gmail.com>
 <1323151347.1745.73.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Chris West (Faux)" <faux@goeswhere.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Bill Zaumen <bill.zaumen@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 07:23:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXoRa-00051b-AE
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 07:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933009Ab1LFGXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 01:23:33 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58203 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909Ab1LFGXc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 01:23:32 -0500
Received: by eeaq14 with SMTP id q14so2555221eea.19
        for <git@vger.kernel.org>; Mon, 05 Dec 2011 22:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=UO+cxup8eYL2YmtQ4y59kgDcioqaLXNPE5eGDujyL+4=;
        b=BKBCxMF/kNWjNhseCz6pJZQp5HlZPTuSHw6QhN+3WVQDPEY15uWEkKtCTEETz3c0or
         Dzrz/61/5puRA7OWOkz0kUao1rX+BK2BTxZ/39BdlnNDwoLrXE5jet8N0WBAHWtUPomx
         lZAo4WnXUeMeL58TxlCBmOsqZ+WwS+0e2/QXM=
Received: by 10.14.15.221 with SMTP id f69mr1872120eef.163.1323152611274; Mon,
 05 Dec 2011 22:23:31 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Mon, 5 Dec 2011 22:23:00 -0800 (PST)
In-Reply-To: <1323151347.1745.73.camel@yos>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186333>

On Tue, Dec 6, 2011 at 1:02 PM, Bill Zaumen <bill.zaumen@gmail.com> wro=
te:
> On Tue, 2011-12-06 at 11:46 +0700, Nguyen Thai Ngoc Duy wrote:
>> On Tue, Dec 6, 2011 at 8:56 AM, Chris West (Faux) <faux@goeswhere.co=
m> wrote:
>> >
>> > Nguyen Thai Ngoc Duy wrote:
>> >>
>> >> SHA-1 charateristics (like 20 byte length) are hard coded everywh=
ere
>> >> in git, it'd be a big audit.
>> >
>> >
>> > I was planning to look at this anyway. =C2=A0My branch[1] allows
>> > =C2=A0init/add/commit with SHA-256, SHA-512 and all the SHA-3 cand=
idates.
>>
>> Great!
>
> If you are replacing SHA-1 as an object ID with another hash function=
,
> two things to watch are submodules and alternative object databases.
> Because of those, it is necessary to worry about the order in which
> repositories are converted. =C2=A0In the worst case for submodules, y=
ou'd
> have to do multiple repositories at the same time, switching between
> them depending on what you need at each point.

I know migration would be painful. But note that new repos can benefit
stronger digest without legacy (of course until it links to an old
repo). For submodules, I think we should extend it to become something
similar to soft-link: git link is an SHA-1 to a text file that
contains SHA-1 and maybe other digests of the submodule's tip.
--=20
Duy
