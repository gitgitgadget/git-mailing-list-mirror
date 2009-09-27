From: =?ISO-8859-1?Q?Alf_Kristian_St=F8yle?= <alf.kristian@gmail.com>
Subject: Re: git stash list shows timestamp in stead of "stash number", when 
	setting date = local for log in config
Date: Sun, 27 Sep 2009 10:25:57 +0200
Message-ID: <49578b170909270125x59d3c627y40fddf4215643121@mail.gmail.com>
References: <49578b170909150756k3c19912dv28615053a6bd0f7d@mail.gmail.com> 
	<20090924070121.GD24486@coredump.intra.peff.net> <20090925222920.GZ14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Sep 27 10:27:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrp6B-0007LO-QJ
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 10:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbZI0I0P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Sep 2009 04:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbZI0I0P
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 04:26:15 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:43097 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbZI0I0N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Sep 2009 04:26:13 -0400
Received: by fxm18 with SMTP id 18so3053294fxm.17
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eZOuryO8VsCeRENEDw6oVoW9dhfvVXQfZ4rYRMUpsLg=;
        b=Hv5j4mckg1cGHaF00wFQQwTskuoFvSgoH8u+1L2HURzzxez+F7meo+aGb9V6Upr8ne
         honk2JcFJlFmOrqk4q/RqvP1qdnxIbQmtTfmivv+x9p+GgFY5R8EBGm/Wq9M+h/g72vW
         cHw7v6Nho2SnGTuZTV6acyOT2jwa1C1Cwib6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mcJkQUR3l2G6kIPdAUWkSCsp6RB90UeO0OokE0OwU+HplyWNGee+0PKUWhZLuEWs8U
         xIKlGp6fVIBfb/VwcBrFwmKV3U3CGv99mretOnsgnX6GnGSwyenXEFwamSDiQCdXG9jc
         oxSUYScst2I8W/LLnERRpcgFROzow42/6HKCs=
Received: by 10.223.27.194 with SMTP id j2mr438506fac.76.1254039977051; Sun, 
	27 Sep 2009 01:26:17 -0700 (PDT)
In-Reply-To: <20090925222920.GZ14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129201>

Hi guys, thanks for the explanation, and thanks for fixing this. I
wasn't aware that stash just is a reflog.

- Alf


On Sat, Sep 26, 2009 at 00:29, Shawn O. Pearce <spearce@spearce.org> wr=
ote:
> Jeff King <peff@peff.net> wrote:
>> On Tue, Sep 15, 2009 at 04:56:41PM +0200, Alf Kristian St??yle wrote=
:
>> > When doing a "git stash list" I get this strange stash record:
>> > stash@{Tue Sep 15 16:28:12 2009}: WIP on master: 2262276 ...
>> >
>> > I have a global config setting on log:
>> >
>> > [log]
>> > date =3D local
>> >
>> > If setting the date config to default or removing the setting, the
>> > stash record looks correct:
>> > stash@{0}: WIP on master: 2262276 ...
>>
>> The patch below implements the former. The only downside I can think=
 of
>> is if somebody is relying on "log.date" to set the output format for
>> reflogs, because they really like the date version better. In that c=
ase,
>> I think we should wait for them to complain (which I doubt will happ=
en),
>> and then add a log.reflogDates config option to appease them.
>>
>> Shawn, reflogs are your thing. Any comments?
>
> I agree. =A0I doubt anyone is relying on log.date to reformat the
> output of `git reflog show` or `git stash list`, so this is probably
> a reasonable change to make. =A0Even if they were trying to use that,
> its a bug.
>
> Care to wrap this up in a patch?
>
> --
> Shawn.
>
