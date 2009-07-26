From: demerphq <demerphq@gmail.com>
Subject: Re: Performance issue of 'git branch'
Date: Sun, 26 Jul 2009 12:27:35 +0200
Message-ID: <9b18b3110907260327q5a6d370g670f79792dfa93e0@mail.gmail.com>
References: <20090723195548.GA28494@Pilar.aei.mpg.de>
	 <20090724234648.GA4616@Pilar.aei.mpg.de>
	 <20090725004122.GA28477@Pilar.aei.mpg.de>
	 <alpine.LFD.2.01.0907251046140.3960@localhost.localdomain>
	 <20090725215739.d074e947.tihirvon@gmail.com>
	 <20090725203130.GB1640@glandium.org>
	 <alpine.LFD.2.01.0907251353410.3960@localhost.localdomain>
	 <20090726075455.GA22525@glandium.org>
	 <alpine.DEB.1.00.0907261214220.8306@pacific.mpi-cbg.de>
	 <9b18b3110907260323h575a0b06rcf058c8b3370b742@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 26 12:33:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV12c-0001mw-Dm
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 12:33:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbZGZKdL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Jul 2009 06:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753392AbZGZKdL
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 06:33:11 -0400
Received: from mail-yx0-f198.google.com ([209.85.210.198]:48754 "EHLO
	mail-yx0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbZGZKdK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jul 2009 06:33:10 -0400
Received: by yxe36 with SMTP id 36so1623436yxe.33
        for <git@vger.kernel.org>; Sun, 26 Jul 2009 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1eIUBcV48RygpEcYVYAFy5kh8RsBlLnSqo87dKIbaJU=;
        b=Cdi2O2mCuWpuuAJm3lQPCr5EzhEe0/gQtgu76h+s+iwN1c/ah4IwJQANhj8MG8C35U
         DGSkDm3b+YtE2AbzwLMDuPtUyrHd4loArqot9kjJYsJWqPZqchwcz/v944ZV8PG7DsLW
         aZjS0rzpCPMnVIbatWRsg/fHsEMqn/LKiiSbk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B7fjNyABg+fb5AELLPNsJ9EIlS6Lvb/DTFbVSmzNVyu4eFWLoMlpX/AiRuYVlLM9LM
         NWT7r2GslJsZym/jAULcr0EiPjxDoADYDo8bfEUSZ782OKfvmhYDB0LfyOc0p2n7Gn+3
         DwXlRkP7ofRDVaLTxMk1NVIdmIkiPv9Z/AeVo=
Received: by 10.231.37.77 with SMTP id w13mr1791543ibd.3.1248604055313; Sun, 
	26 Jul 2009 03:27:35 -0700 (PDT)
In-Reply-To: <9b18b3110907260323h575a0b06rcf058c8b3370b742@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124120>

2009/7/26 demerphq <demerphq@gmail.com>:
> 2009/7/26 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>> Hi,
>>
>> On Sun, 26 Jul 2009, Mike Hommey wrote:
>>
>>> On Sat, Jul 25, 2009 at 02:02:19PM -0700, Linus Torvalds wrote:
>>> >
>>> >
>>> > On Sat, 25 Jul 2009, Mike Hommey wrote:
>>> >
>>> > > On Sat, Jul 25, 2009 at 09:57:39PM +0300, Timo Hirvonen wrote:
>>> > > > Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>> > > >
>>> > > > > So curl really must die. It may not matter for the expensiv=
e operations,
>>> > > > > but a lot of scripting is about running all those "cheap" t=
hings that just
>>> > > > > add up over time.
>>> > > >
>>> > > > SELinux is the problem, not curl.
>>> > >
>>> > > I think it's NSS, the problem, not SELinux. Linus's libcurl is =
built
>>> > > against NSS, which is the default on Fedora.
>>> >
>>> > Well, it kind of doesn't matter. The fact is, libcurl is a bloate=
d
>>> > monster, and adds zero to 99% of what git people do.
>>>
>>> Especially consideting the http transport fails to be useful in var=
ious
>>> scenarios.
>>
>> I beg your pardon? =A0Maybe "s/useful/desirable/"?
>>
>> In many scenarios, http transport is the _last resort_ against overz=
ealous
>> administrators. =A0The fact that you might be lucky enough not to ne=
ed that
>> resort is a blessing, and does not give you the right to ridicule th=
ose
>> who are unfortunate enough not to share your good luck.
>
> I think he meant that it is buggy and does not work correctly in
> various scenarios.
>
> Eg: Last I checked it couldn't handle repos where the main branch
> wasn''t called master, and I've seen other messages that make me thin=
k
> it doesn't work correctly on edge cases.

Er, I meant that to go to Johannes directly, not to spam the list or
the cc's with my hazy recollection, and I should have added: "but
perhaps im confusing http and rsync".

Sorry for the noise.

Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
