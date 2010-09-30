From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Pull request for msysGit patches
Date: Thu, 30 Sep 2010 23:15:10 +0100
Message-ID: <8739sqj2tt.fsf@fox.patthoyts.tk>
References: <87ocbitd33.fsf@fox.patthoyts.tk>
	<7vocbhsn03.fsf@alter.siamese.dyndns.org>
	<AANLkTinpSwuhT1_wtqNBeXLCud-F0bLBUgbohdtPp+8R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	bert Dvornik <dvornik+git@gmail.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 00:15:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1RPw-0001xq-DQ
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 00:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780Ab0I3WPY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 18:15:24 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:50519 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756723Ab0I3WPW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 18:15:22 -0400
Received: from [172.23.170.142] (helo=anti-virus02-09)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P1RPL-0002Xt-IU; Thu, 30 Sep 2010 23:15:19 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P1RPG-0003fT-Ds; Thu, 30 Sep 2010 23:15:14 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 545532C997; Thu, 30 Sep 2010 23:15:13 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTinpSwuhT1_wtqNBeXLCud-F0bLBUgbohdtPp+8R@mail.gmail.com>
	(=?iso-8859-1?Q?=22=C6var_Arnfj=F6r=F0?= Bjarmason"'s message of "Tue, 28
 Sep 2010 21:23:19
	+0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157716>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

>On Tue, Sep 28, 2010 at 19:10, Junio C Hamano <gitster@pobox.com> wrot=
e:
>
>> git-send-email.perl
>>
>> Similar comment as is_absolute_path(), although in Perl environment =
I
>> suspect we can just use an existing package without adding our own.
>
>It seems to me that the code added by Erik Faye-Lund in
>33b2e81f84875bf515b4c0de830eeddfd04227dc and this new code in
>"send-email: handle Windows paths for display just like we do for
>processing" by bert could both be replaced by:
>
>    use File::Spec::Functions qw(file_name_is_absolute);
>    file_name_is_absolute($some_path);
>
>And by doing so we'd also be compatible with e.g. VMS. Can the people
>with the odd non-Unix systems maybe try this out and see if it works?
>:)

I just looked into using this function with msysGit. Unfortunately it
doesn't work as our perl is msys-compiled and doesn't recognise c:\ as
an absolute path. It's using the unix path functions.
Possibly we could use a native perl if the git perl functions were
making more use of these platform-abstracting functions. Ultimately thi=
s
is the right way to go.
