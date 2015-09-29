From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Why not git reset --hard <path>?
Date: Tue, 29 Sep 2015 20:40:34 +0100
Organization: OPDS
Message-ID: <600ECF9ED63D4A3BAC16F3E29DB656D4@PhilipOakley>
References: <20150928203449.29024.qmail@ns.horizon.com> <xmqq612ucm3p.fsf@gitster.mtv.corp.google.com> <CA+P7+xoTHFL_KU+qBz1KwytxqNTxf1JkjXK7_Ej79uLLnCWD8g@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "George Spelvin" <linux@horizon.com>,
	"Git List" <git@vger.kernel.org>
To: "Jacob Keller" <jacob.keller@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 29 21:40:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zh0lW-0001Ez-Nc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 21:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbI2Tkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2015 15:40:39 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:23023 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750703AbbI2Tki (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Sep 2015 15:40:38 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CCOAAo6ApWPAi0BlxeGQEBgwmBPYZZbb4fBAKBU00BAQEBAQEHAQEBAUEkG0EBAgEBg1kFAQEBAQMIAQEZDwEFHgEBIQsCAwUCAQECFQMCAgUhAgIUAQQIEgYHAxQGARIIAgECAwGICAMWmgGdLIZYiHENhTSBIoVRhH2CUII9gnAvgRQFlXQBgRyKBpVsh0iCdByBVT0zgwOBaYFPgmMBAQE
X-IPAS-Result: A2CCOAAo6ApWPAi0BlxeGQEBgwmBPYZZbb4fBAKBU00BAQEBAQEHAQEBAUEkG0EBAgEBg1kFAQEBAQMIAQEZDwEFHgEBIQsCAwUCAQECFQMCAgUhAgIUAQQIEgYHAxQGARIIAgECAwGICAMWmgGdLIZYiHENhTSBIoVRhH2CUII9gnAvgRQFlXQBgRyKBpVsh0iCdByBVT0zgwOBaYFPgmMBAQE
X-IronPort-AV: E=Sophos;i="5.17,609,1437433200"; 
   d="scan'208";a="560188892"
Received: from host-92-6-180-8.as43234.net (HELO PhilipOakley) ([92.6.180.8])
  by out1.ip03ir2.opaltelecom.net with SMTP; 29 Sep 2015 20:40:35 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278834>

=46rom: "Jacob Keller" <jacob.keller@gmail.com>
> On Mon, Sep 28, 2015 at 1:42 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> "George Spelvin" <linux@horizon.com> writes:
>>> I understand that "git reset --soft" makes no sense with a path, bu=
t
>>> why not --hard?
>>
>> I do not think there is anything fundamentally wrong for wishing for
>> "reset --hard <pathspec>".  It probably is just that nobody needed
>> it, because "git checkout HEAD <pathspec>" is a 99% acceptable
>> substitute for it (the only case where it makes a difference is when
>> you added a path to the index that did not exist in HEAD).
>>
>
> Personally, I would like to see this simply given the number of times
> that I use git reset --hard <path> and then realize I should have use=
d
> git checkout instead. I conceptually think reset --hard should do
> that, and that checkout is really not meant to do that as a concept.
>
> I may have some time to try and give this a look in the next few days=
=2E..
>
> Regards,
> Jake
> --

I also recently had this problem of expecting to be able to use somethi=
ng=20
like `git reset --hard -- <path>` to clear up some crud and having to c=
ast=20
around for the right approach.

Would it at least be worth flagging up the alternate ` git checkout  --=
 =20
path` a little better within the 'get reset' man pages? At the moment i=
ts=20
hidden at the end of the git reset [-q] [<tree-ish>] [--] <paths>=E2=80=
=A6=E2=80=8B section,=20
so is easily missed.

(i.e. should I flesh out a patch, or would the nuances bury it...?)

Philip
