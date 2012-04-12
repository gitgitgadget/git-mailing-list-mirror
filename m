From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: Add support for dumping out long options
Date: Thu, 12 Apr 2012 00:12:32 -0700
Message-ID: <4F868060.1000709@gmail.com>
References: <1334140165-24958-1-git-send-email-bebarino@gmail.com> <1334140165-24958-2-git-send-email-bebarino@gmail.com> <20120411140651.GR2289@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org,
	felipe.contreras@gmail.com, jrnieder@gmail.com
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Apr 12 09:12:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIECt-0000NO-Un
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 09:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762063Ab2DLHMf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Apr 2012 03:12:35 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50923 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468Ab2DLHMe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 03:12:34 -0400
Received: by obbtb18 with SMTP id tb18so2348253obb.19
        for <git@vger.kernel.org>; Thu, 12 Apr 2012 00:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=urZqIrYHUwP3emGY7EXWXY6PFTfaAvrhVCHB/cE66Do=;
        b=CCbAoX6/TvU5jXH+TsHYoiwE2BDcEtAM9VSwYH3w6qWMFgHHcspo7SS0LmlpoYmtKA
         QsFA3akQytQ+UzZFDR1UGvoDwCytayjCzsKx9Xxwcg5g+2w6BUPmjp0TsPOvNT5ky4VN
         LGyxVDCA2ZkQ1uOCQsT0TmyvF22TBz5BpJcOqMtUtlcBZugfSjGnnmdpm1eaSb2a6ZhC
         cA6wk7Dk1FdNjfw0wItkrCihJjxLh2YOiNWZkyJwsOSy1jzIr19aUQUzNtLaLPII87tW
         d/6yDNqfl3MUrpskygs5K4hYII7JAB91sc46EpecXfhsg3ekVOYdV3DV+f/9Ond4ZpPJ
         /+Gw==
Received: by 10.182.51.9 with SMTP id g9mr1593535obo.56.1334214754233;
        Thu, 12 Apr 2012 00:12:34 -0700 (PDT)
Received: from [192.168.2.10] (ip68-105-100-241.sd.sd.cox.net. [68.105.100.241])
        by mx.google.com with ESMTPS id k7sm4988260oei.0.2012.04.12.00.12.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Apr 2012 00:12:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110911 Thunderbird/6.0
In-Reply-To: <20120411140651.GR2289@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195307>

On 04/11/2012 07:06 AM, SZEDER G=E1bor wrote:
> On Wed, Apr 11, 2012 at 03:29:24AM -0700, Stephen Boyd wrote:
>> The bash completion script wants to know what the long options are f=
or a
>> certain command at runtime. Add a magical long option that nobody co=
uld
>> possibly ever use (--dump-raw-long-options) to get this information.
>>
>> Some example output:
>>
>>  $ git clone --dump-raw-long-options
>>  --no-verbose --no-quiet --progress --no-progress --no-checkout
>>  --checkout --bare --no-bare --mirror --no-mirror --local --no-local
>>  --no-hardlinks --hardlinks --shared --no-shared --recursive
>>  --no-recursive --recurse-submodules --no-recurse-submodules --templ=
ate=3D
>>  --no-template --reference=3D --no-reference --origin=3D --no-origin
>>  --branch=3D --no-branch --upload-pack=3D --no-upload-pack --depth=3D
>>  --no-depth --single-branch --no-single-branch --separate-git-dir=3D
>>  --no-separate-git-dir --config=3D --no-config
>>
>=20
> I think this is a good idea; there are many completion functions that
> fell behind and lack an option or two.
>=20
> However, in the completion script we deliberately miss options like
> '--force', but with your series such options will be offered, too.
>=20

Hm.. I meant to say something about that in the commit text. I'm willin=
g
to live with wading through some more options when I tab complete if it
means the script never falls out of date with my git installation.

I can envision us putting more smarts into the parse options code to
hide certain options from the raw dump but I'm not sure how useful that
is. Do we need that?
