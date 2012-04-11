From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 07/12] completion: simplify command stuff
Date: Thu, 12 Apr 2012 01:21:17 +0300
Message-ID: <CAMP44s3hYHxs2HZ59meEO=SU7gXuxU=m489LdxV38=7PDeDFdw@mail.gmail.com>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
	<1333854479-23260-8-git-send-email-felipe.contreras@gmail.com>
	<20120411221430.GT2289@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:21:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5um-0007Mj-4v
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 00:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761364Ab2DKWVT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Apr 2012 18:21:19 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42173 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761289Ab2DKWVS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 18:21:18 -0400
Received: by eekc41 with SMTP id c41so350967eek.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 15:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qgPOAyrz+tYx4Io6bRaghEJj0TZBZGz9akpiukHJqfk=;
        b=npWsmvYtZCgy6EyNKr826wuink7D6a7428UOpg1AhRDXf60cT33zLqpdqn63J//k5m
         7IyE0Szhsv+3zMRvb+mNM+0cpDakp83ToqnnWHlqPPT5ZWlpvERb9JzIFQz6qcT98SWj
         rzDSjFG8VlTsYzQCXmnLRCMs9g5qNkh3KrfMcxxdjK62wWbFNtYX1DvC0iisTpFUKew6
         YOceftVZY18VL35ozaIRJ5eLCodL5QN07NidMqahj6Y5k0/UKAV+d3tcwYJNyIHDJGSf
         27Z0KyY27nNJKuan3hllHBSnMosix+4DE16jdTMTndCGImCh7VhaGlED5chR5jcA7fe0
         kFbw==
Received: by 10.213.114.72 with SMTP id d8mr40765ebq.143.1334182877341; Wed,
 11 Apr 2012 15:21:17 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Wed, 11 Apr 2012 15:21:17 -0700 (PDT)
In-Reply-To: <20120411221430.GT2289@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195277>

2012/4/12 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> Hi,
>
>
> On Sun, Apr 08, 2012 at 06:07:54AM +0300, Felipe Contreras wrote:
>> No need to recalculate it.
>
> Based on this short description I would expect that this "command
> stuff" is calculated somewhere, and a helper function is changed to
> use the already calculated value ...

[...]

> ... but the bulk of this change is in the top-level _git() function,
> as it renames a variable there to match the variable name in the
> helper function. =C2=A0Perhaps it should be the other way around.
>
> However, this change "promotes" the command (or cmd) variable from
> being just a variable in _git() to a variable that is used in other
> completion functions, too. =C2=A0Why not go one more step further, an=
d
> denote this by adding a __git prefix (i.e. renaming the variable to
> __git_command)?

After thinking more about it, and analyzing the next patches, I don't
think it makes sense to have such a variable; it's only used by
__git_complete_remote_or_refspec, and it would be easier to make it an
argument to that function; that would simplify this patch series a
lot.

Cheers.

--=20
=46elipe Contreras
