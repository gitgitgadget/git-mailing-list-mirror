From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] completion: cleanup __gitcomp*
Date: Mon, 30 Jan 2012 18:25:26 -0600
Message-ID: <20120131002526.GB2678@burratino>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-4-git-send-email-felipec@infradead.org>
 <20120130175004.GG10618@burratino>
 <20120131001535.GB2632@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipec@infradead.org>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jan 31 01:25:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rs1Xa-0007HF-50
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 01:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab2AaAZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 19:25:35 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:62574 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab2AaAZe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 19:25:34 -0500
Received: by ggnh1 with SMTP id h1so10737ggn.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 16:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=trHdHgy9ICq1RAzJlA6dk7WB4Yo+BagxJTiS5DvRpKY=;
        b=Ez7Q4vDF+xEPA0C397rL1C9yA8Xb/2QBEpnARV8vaJwnSIChHkWxRdOofH2iRJAppk
         LCQdonWaW11KOnEY4B6mbYXd6LCWjF2QvxHF2GmjN9bmrpq8Rx1tOGk6YpXy8NOK/oe/
         eO7SAOG3D4BMcP1WLGpuEuYGHhPPeiFsOMNT8=
Received: by 10.101.152.7 with SMTP id e7mr8862808ano.83.1327969534410;
        Mon, 30 Jan 2012 16:25:34 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i1sm9602951and.19.2012.01.30.16.25.33
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 16:25:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120131001535.GB2632@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189440>

SZEDER G=C3=A1bor wrote:
> On Mon, Jan 30, 2012 at 11:50:04AM -0600, Jonathan Nieder wrote:

>> I imagine it would have been enough to say something along the lines=
 of
>> "The __gitcomp and __gitcomp_nl functions are unnecessarily verbose.
>> __gitcomp_nl sets IFS to " \t\n" unnecessarily
>
> Yeah, that's unnecessary.  I'm not sure why I did that, perhaps just
> blindly followed suit of gitcomp_1(), without realizing that I don't
> do any word-splitting in __gitcomp_nl() except when invoking compgen.
>
>> before setting it to "\n"
>> by mistake.
>
> But that is deliberate, that's why it's called __gitcomp_nl(), see
> a31e6262 (completion: optimize refs completion, 2011-10-15), third
> paragraph.

Yep, sorry for the ambiguity.  I meant that setting IFS to " \t\n"
(before setting it to "\n") was not done for any serious reason.
The explanation is definitely clearer with "by mistake" dropped.

Thanks,
Jonathan
