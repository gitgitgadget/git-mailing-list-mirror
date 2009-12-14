From: Jason King <jk@silentcow.com>
Subject: Re: am fails to apply patches for files with CRLF lineendings
Date: Mon, 14 Dec 2009 13:16:40 -0800
Message-ID: <B86FC676-FEAE-482D-953D-701A01FD2877@silentcow.com>
References: <20091214183337.GA25462@atjola.homenet> <7vvdg9i9mn.fsf@alter.siamese.dyndns.org> <776A5AB0-E6BC-4230-800E-BE1B7A6B09BF@silentcow.com> <20091214205517.GA1317@atjola.homenet>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:16:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKIHm-0007uK-At
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 22:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932993AbZLNVQt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 16:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932979AbZLNVQt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 16:16:49 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42407 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932633AbZLNVQs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 16:16:48 -0500
Received: by bwz27 with SMTP id 27so2428789bwz.21
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 13:16:47 -0800 (PST)
Received: by 10.204.26.152 with SMTP id e24mr3164853bkc.119.1260825407006;
        Mon, 14 Dec 2009 13:16:47 -0800 (PST)
Received: from ?192.168.2.172? (wsip-72-214-22-18.sd.sd.cox.net [72.214.22.18])
        by mx.google.com with ESMTPS id 13sm1328891bwz.14.2009.12.14.13.16.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 14 Dec 2009 13:16:45 -0800 (PST)
In-Reply-To: <20091214205517.GA1317@atjola.homenet>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135239>

On Dec 14, 2009, at 12:55 PM, Bj=F6rn Steinbrink wrote:

> On 2009.12.14 12:38:30 -0800, Jason King wrote:
>> On Dec 14, 2009, at 12:27 PM, Junio C Hamano wrote:
>>
>>> Bj=F6rn Steinbrink <B.Steinbrink@gmx.de> writes:
>>>
>>>> Commit c2ca1d7 "Allow mailsplit ... to handle mails with CRLF
>>>> line-endings"
>>>> seems to be responsible.
>>>
>>> Yes, that commit is not only responsible but was deliberate.  For
>>> a better
>>> backstory, see:
>>>
>>> http://thread.gmane.org/gmane.comp.version-control.git/124718/focus=
=3D124721
>>>
>>> You'd notice that I was one of the people who didn't want to have =20
>>> this
>>> change, so you don't need to convince _me_ that this was not a
>>> change to
>>> keep everybody happy, but you'd need to try a better job than I
>>> did back
>>> then to convince people who thought that "am" should directly work =
=20
>>> on
>>> "Thunderbird saved mails" that what they want was a bad idea X-<.
>>
>> I dunno Junio, the back story doesn't really seem like a convincing
>> argument for totally breaking am's handling of real CRLFs.  Right
>> now, it seems to be a very bad thing that git can create a patch
>> that it can't apply.  The default am should always be able to apply
>> whatever format-patch has generated.
>>
>> If it's desirable to have am translate CRLFs to LFs, then why not
>> provide this as an option to am so as not to break merging of real
>> CRLF patches?  Eg.:
>>
>>  git am --convert-crlf
>
> Hm, currently it checks everyline. I didn't really think this through=
,
> but wouldn't it makes sense to have a per-mail flag, that checks just
> the first line, and if that has CRLF, then enable the dropping (unles=
s
> --keep-cr is given), otherwise, keep things verbatim. That should (I
> think) make things work with non-messed up patches regardless of the
> files being patch, as well as with messed up patches as long as they
> don't try to patch files with CRLF line-endings.

Sure, it won't affect LFers at all if you test the header lines of the =
=20
patch file - we'll be immune from that conversion then.  Works for me :=
)

Thanks again,
Jason
