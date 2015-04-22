From: Dave Boutcher <daveboutcher@gmail.com>
Subject: Re: [PATCH 1/3] git-multimail: Add an option to filter on branches
Date: Wed, 22 Apr 2015 18:46:36 +0800
Message-ID: <CAEXuECi=UDo7_0O22+Gi1yew1M=LrrKLXNT9gdSvdgQwCxYjow@mail.gmail.com>
References: <1429657487-10809-1-git-send-email-daveboutcher@gmail.com>
	<55377A60.707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 22 12:47:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YksBJ-0002Wp-43
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 12:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463AbbDVKql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 06:46:41 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33533 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbbDVKqi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 06:46:38 -0400
Received: by wiax7 with SMTP id x7so127126340wia.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 03:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=vmyU3JmbD6HGkqTgbNQe5gEzvbJLrWD+n7WF4ZkRZ+8=;
        b=e8OETxKRyueLmitswkr6ORJOPOhqJMwLyTvj+VAWcAS6XZTir17xeE0E3Al8okX0ij
         n8vOB2Z519N0sHEqxwbEYRWz8K4trKqFb7J7WwmPEZjTY2pH7MpDAeFrXiBGpBFmAnhz
         Ys3Hm+iPlk1mqSjjyL3Wg4E0IjbCeu4DYCldKCzmkhx23X2ax78/Cn5qfuyXuzC7U0KW
         19d4d+j64ZlMCPAgWwr+Z25aoZQPNz6Zogq/Co9tpKm/chPjK5Y9EorYkXmraUNGMPbS
         1IOsKPKPMc89tmBE0SC7LngoexQO5EGx4UazR5V/cdFK8FTAKpTp6BIGraEihp+FsQKy
         L3qg==
X-Received: by 10.180.81.3 with SMTP id v3mr4630986wix.36.1429699596979; Wed,
 22 Apr 2015 03:46:36 -0700 (PDT)
Received: by 10.27.91.207 with HTTP; Wed, 22 Apr 2015 03:46:36 -0700 (PDT)
In-Reply-To: <55377A60.707@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267585>

Thanks Michael,

The only code I'm not fond of is matching on a list of regular
expressions.  There must be a more pythonic way to do:

+ return [x for x in [r.match(branch) for r in branches] if x]

which basically returns true if "branch" matches any regular
expression in the list.

I pushed this change out to our production git server (its good to be
the king.)  I'll obviously update here if it does anything too
unfortunate.


On Wed, Apr 22, 2015 at 6:39 PM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> On 04/22/2015 01:04 AM, Dave Boutcher wrote:
>> Add a branches option to the config.  Only changes
>> pushed to specified branches will generate emails. Changes to tags
>> will continue to generate emails.
>
> Thanks for the patches. Patches 2 and 3 seem uncontroversial, so I
> already merged them. Patch 1 is more interesting, and there have been
> other proposals for similar features, so I created a pull request for=
 it:
>
>     https://github.com/git-multimail/git-multimail/pull/75
>
> (Note the new URL--I just created a GitHub "organization" for
> git-multimail to make it easier for other people to get involved. Mor=
e
> info soon...)
>
> Michael
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
>



--=20
Dave B
=E5=8C=85=E5=B0=8F=E9=BE=99
