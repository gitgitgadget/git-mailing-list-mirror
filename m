From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH/RFC] init, clone: support --real-git-dir for .git file
Date: Fri, 4 Mar 2011 19:09:21 +0100
Message-ID: <AANLkTinQCZXYAbndLuRVVEr6NTRA8aaypFfvtqNjknLQ@mail.gmail.com>
References: <1299156201-12149-1-git-send-email-pclouds@gmail.com>
	<4D700469.7090807@gmail.com>
	<7vhbbj93yb.fsf@alter.siamese.dyndns.org>
	<AANLkTin8Gnbyji4sz6cnWLcAzC2RAS_wnd_o3avDvsvG@mail.gmail.com>
	<AANLkTiksQg1U=uAEVJG8fyjd7HpsTqgBOdyh6wrEMSED@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 19:09:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvZRR-0006to-0z
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 19:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759747Ab1CDSJX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Mar 2011 13:09:23 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46428 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883Ab1CDSJW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Mar 2011 13:09:22 -0500
Received: by vxi39 with SMTP id 39so2237536vxi.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2011 10:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aaEF1VESQjIl6Z2NF3VUeAT4Pgf1i43+7sY5XmixfPo=;
        b=ITV8dl8vRlWy4PYMKyrYt10+WusFBa92mtutvO6AC/zLte2DtHOzBpImboiZ2olTKA
         n31aqhM7TPRjQOPitKuCzWLCHzIDgMIJrDWJ9pUlwqYfIOQLeguW54GM2AozKmxAhNb8
         FSJN3gdgBYZKQ0f8CPJ3UUzNujxBOAUBWoZsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YO+zLIE+w+voIP4r4M2s+WiBBsQbV/hq6o8MDY++19JFnPYZ9zhP+nRo4YoVDLQVKD
         RAWHxD4iEenfnwn37rNdkkwmyi55Mi8uwLqEW+M+TsWDSaa0agMlL5RchsUZymy5poco
         bSkzVGeyelxltthIlINUyJUfs6SchoRk+c9gs=
Received: by 10.52.72.232 with SMTP id g8mr1424874vdv.108.1299262161588; Fri,
 04 Mar 2011 10:09:21 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Fri, 4 Mar 2011 10:09:21 -0800 (PST)
In-Reply-To: <AANLkTiksQg1U=uAEVJG8fyjd7HpsTqgBOdyh6wrEMSED@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168455>

On Fri, Mar 4, 2011 at 1:26 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> 2011/3/4 Piotr Krukowiecki <piotr.krukowiecki@gmail.com>:
>> I thought it was user-level file, like $GIT_DIR
>>
>> I'm not into data duplication, but in this case the message is next =
to the
>> previous use:
>>
>> =A0 =A0 =A0 if (prefixcmp(buf, "gitdir: "))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("Invalid gitfile format: %s\nUse git=
dir: <PATH>", path);
>>
>>
>> BTW I think it might be enough to have just path in the .git file. I=
f
>> .git has path
>> to a correct git repo then chances it's coincidence are quite low.
>> (The format does not matter if it's internal file of course)
>
> It's actually good that path is prefixed by gitdir. I imagine once
> superproject is supported, .git file in subprojects will have another
> line
>
> supergitdir: /path/to/superproject

Why would it be better than keeping this information under .git/, in co=
nfig
or other specific file?



--=20
Piotrek
