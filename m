From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Pull request for msysGit patches
Date: Fri, 1 Oct 2010 01:27:55 +0200
Message-ID: <AANLkTik=dR25Z6SbOd7Mn3FE73vUrLTqDcSUN7G2X_48@mail.gmail.com>
References: <87ocbitd33.fsf@fox.patthoyts.tk> <7vocbhsn03.fsf@alter.siamese.dyndns.org>
 <AANLkTinpSwuhT1_wtqNBeXLCud-F0bLBUgbohdtPp+8R@mail.gmail.com> <8739sqj2tt.fsf@fox.patthoyts.tk>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	bert Dvornik <dvornik+git@gmail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 01 01:28:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1SY3-0004oe-4h
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 01:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab0I3X2R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 19:28:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57277 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550Ab0I3X2Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 19:28:16 -0400
Received: by gwj17 with SMTP id 17so975132gwj.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=yxBRReX4zzni1EgZK1PKizbbjo+X5mvHSP+n02aS0D4=;
        b=ue9UvccC6OrKU12ONO+Krb87zfV0Ote9eq74tdrCRmtS9vSZX+SjYokd7ubqWSnS7Z
         QnV+7iz0DHDKG+HI2MgFaj514QMFF845Z/dblSlb9B/wjG38Ow/YcenedGC0v75QCGom
         SHLm+JME7YGoMpKy7qhwoGiN4fc1PumG0mz58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=XLWpmsIr71P9DzsSqZ3yiRUM6d9Z0yoq/hFnX8TcAUQLquL82n76yGMpeu3OLcJPhn
         hicdzj2qMlQGiSY6XnalM341O0c2+LeJM6UFg8dCj2NmWq1guHCF426fgSpsSYSWJwHU
         mwL6Tzwpb58v0RmK2FNt31siZB6gnk0fyvqbo=
Received: by 10.220.168.10 with SMTP id s10mr1184653vcy.50.1285889295427; Thu,
 30 Sep 2010 16:28:15 -0700 (PDT)
Received: by 10.220.100.135 with HTTP; Thu, 30 Sep 2010 16:27:55 -0700 (PDT)
In-Reply-To: <8739sqj2tt.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157721>

On Fri, Oct 1, 2010 at 12:15 AM, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>
>>On Tue, Sep 28, 2010 at 19:10, Junio C Hamano <gitster@pobox.com> wro=
te:
>>
>>> git-send-email.perl
>>>
>>> Similar comment as is_absolute_path(), although in Perl environment=
 I
>>> suspect we can just use an existing package without adding our own.
>>
>>It seems to me that the code added by Erik Faye-Lund in
>>33b2e81f84875bf515b4c0de830eeddfd04227dc and this new code in
>>"send-email: handle Windows paths for display just like we do for
>>processing" by bert could both be replaced by:
>>
>> =A0 =A0use File::Spec::Functions qw(file_name_is_absolute);
>> =A0 =A0file_name_is_absolute($some_path);
>>
>>And by doing so we'd also be compatible with e.g. VMS. Can the people
>>with the odd non-Unix systems maybe try this out and see if it works?
>>:)
>
> I just looked into using this function with msysGit. Unfortunately it
> doesn't work as our perl is msys-compiled and doesn't recognise c:\ a=
s
> an absolute path. It's using the unix path functions.
> Possibly we could use a native perl if the git perl functions were
> making more use of these platform-abstracting functions. Ultimately t=
his
> is the right way to go.
>

Unfortunately, changing our perl is easier said than done, see issue
218 in the msysGit issue tracker for some of the nasty details:
http://code.google.com/p/msysgit/issues/detail?id=3D218
