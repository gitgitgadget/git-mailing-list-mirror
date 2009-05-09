From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 3/3] completion: use specified file (if any) when completing
 config vars
Date: Fri, 08 May 2009 18:00:25 -0700
Message-ID: <4A04D5A9.1090901@gmail.com>
References: <1241676906-29783-1-git-send-email-bebarino@gmail.com>	 <1241677093-29937-1-git-send-email-bebarino@gmail.com>	 <1241677093-29937-2-git-send-email-bebarino@gmail.com>	 <20090507151207.GQ30527@spearce.org> <780e0a6b0905071255g4ade6316oace6a2be6a6d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 09 03:01:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2awQ-0001hF-Lu
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 03:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbZEIBAc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2009 21:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbZEIBAc
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 21:00:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:23934 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932500AbZEIBAb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 21:00:31 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1388675rvb.1
        for <git@vger.kernel.org>; Fri, 08 May 2009 18:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=AgfzGBFUxUatAptgdk+siSdgwxbDmT2patX21ZW16g8=;
        b=QWGe+71KY0AE1oHtkeUaR/5FOqG4x6CLTGr+AJyYGng7QUERX4HgwMwNoOXbHW7DgW
         irs/fv3uvT/sHxjHNTIuNqCtnEm4p+6rG/4RnSknPLynFQg6V6p9RmkeE9rRTDFRNAcv
         pSRBvjvFsjExI8AU4oqipDprrNlc0OXtH8MCU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nCu5xHgkPiSK4+8qeihiwWxhtb0BQWQ9D5HTkKXEWP3mT11eZ/JOnlidsli3O7JoPl
         5pIrJ4Lk4GOaY88X3R9devtTj3n9gOkSh6zDBCKcn+6JF7smCCstzLY+JSpuxX1p27gN
         0j8807/c+xpDv2rDOlenahA4+6yXQWANKWSBk=
Received: by 10.142.238.20 with SMTP id l20mr1736292wfh.169.1241830829272;
        Fri, 08 May 2009 18:00:29 -0700 (PDT)
Received: from ?192.168.1.2? ([76.89.212.195])
        by mx.google.com with ESMTPS id 30sm4779797wfa.15.2009.05.08.18.00.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 May 2009 18:00:28 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <780e0a6b0905071255g4ade6316oace6a2be6a6d2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118641>

Stephen Boyd wrote:
> On Thu, May 7, 2009 at 8:12 AM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
>> Wow, this is a lot of magic.
>>
>> Try:
>>
>> =C2 git config --global remote.gitster.url $(git config remote.o<TAB=
>
>>
>> You'll complete against --global, not the local repository
>
> Yeah, I didn't think it would be very robust. Is it a good idea to
> keep going down this path, or is it too magical? This example could b=
e
> fixed by searching the words backwards, but I imagine there is some
> other case where that will fail. Also, --global and --system don't
> have values, so right now it's all wrong (i.e. config_file is
> "--global remote.gitster.url" for this example).

After further investigation, I can't get the tab completion you talk
about here to work at all. Should it work?

I've reworked this into two patches which I'll send as a follow up soon=
=2E
