From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Sun, 11 Apr 2010 09:33:15 +1000
Message-ID: <s2l2cfc40321004101633y2857f592q2a62c5c90ea7a9de@mail.gmail.com>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
	 <20100410040959.GA11977@coredump.intra.peff.net>
	 <9c7e1f33b7ec0dab68a92aa8f067989e@212.159.54.234>
	 <h2j2cfc40321004100756g15ad7f12jf37e500f924e7b96@mail.gmail.com>
	 <8871c8959d3ea4cd71452400e4c60dd0@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Eric Raymond <esr@snark.thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 11 01:33:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0kB1-0007iH-8k
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 01:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab0DJXdR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 19:33:17 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:39878 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab0DJXdQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 19:33:16 -0400
Received: by qyk9 with SMTP id 9so2660796qyk.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 16:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=86lqfICYNZLDA21k2G96ViFpvAfhYJJ+zqJTubev2Ms=;
        b=k2TKhdhG0/SMEVuIm79xBTkr7tREsuHiiqSAHkksNxHAmj7g8plSphNHET9h3Jo7L7
         +uYcupjEYBphw6daT7xbY4uW3RvafDZxBsmicmUMD9RC41DMFM4LCMn20b02MCXmQ5zS
         9gJrOFm6UFGdMaGV1nl0f8yd1j24pot9W95Uo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eRgsWu2rGZeyMc6P/VX3KrAm9OeWKWrn7jjhpgJFRbh635IIgGJLWCvyLIeTu49G9c
         n1DNrLMaRHJKyB9eaRKLgEdXkISlpAHLiy4r0J+9C0Hlsr9qp4chEClbw34wCrHLqe2x
         cemLZdtr8ALTmxvEdWJKjXn+rVtXykvThbV78=
Received: by 10.229.185.136 with HTTP; Sat, 10 Apr 2010 16:33:15 -0700 (PDT)
In-Reply-To: <8871c8959d3ea4cd71452400e4c60dd0@212.159.54.234>
Received: by 10.229.88.72 with SMTP id z8mr3261694qcl.3.1270942395362; Sat, 10 
	Apr 2010 16:33:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144614>

On Sun, Apr 11, 2010 at 1:50 AM, Julian Phillips
<julian@quantumfyre.co.uk> wrote:
> On Sun, 11 Apr 2010 00:56:47 +1000, Jon Seymour <jon.seymour@gmail.co=
m>
> wrote:
>> On Sat, Apr 10, 2010 at 11:35 PM, Julian Phillips
>> <julian@quantumfyre.co.uk> wrote:
>>> ...
>>> tokens depending on the status flags. =C2=A0So it would make the pa=
rsing
>>> simpler. =C2=A0But to make it even easier, how about adding a -Z th=
at makes
>>> the
>>> output format "XY\0file1\0[file2]\0" (i.e. always three tokens per
>>> record,
>>> with the third token being empty if there is no second filename)?
>>> =C2=A0Though
>>> if future expandability was wanted you could end each record with \=
0\0
>>> and
>>> then parsing would be a two stages of split on \0\0 for records and
> then
>>> split on \0 for entries?
>>
>> Surely that won't work - if file2 can be empty, \0[file2]\0 reduces =
to
>> \0\0 which would be confused with the \0\0 proposed as a record
>> separator.
>
> Yes. =C2=A0But they were alternative suggestions, so if using \0\0 as=
 the
> record marker you would omit the second filename when empty as is cur=
rently
> done.

Ah, apologies. I appear to have failed to parse a necessary disjunctive=
 :-)

jon.
