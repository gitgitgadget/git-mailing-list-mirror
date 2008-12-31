From: "Hannes Eder" <hannes@hanneseder.net>
Subject: Re: [STGIT][PATCH] new: translate non word characters in patch name to '-'
Date: Wed, 31 Dec 2008 09:07:51 +0100
Message-ID: <154e089b0812310007j6642af70v4bfd64b784da8b4c@mail.gmail.com>
References: <49562413.0437560a.287d.5133@mx.google.com>
	 <20081228204938.GA13143@diana.vm.bytemark.co.uk>
	 <154e089b0812291215h72dfe04aod080f665eb7f5592@mail.gmail.com>
	 <20081229212119.GA3015@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 09:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHw8g-00071t-00
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 09:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbYLaIHy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Dec 2008 03:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752377AbYLaIHy
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 03:07:54 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:59495 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYLaIHx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Dec 2008 03:07:53 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2031571fgg.17
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 00:07:51 -0800 (PST)
Received: by 10.86.50.6 with SMTP id x6mr9185206fgx.71.1230710871594;
        Wed, 31 Dec 2008 00:07:51 -0800 (PST)
Received: by 10.86.84.16 with HTTP; Wed, 31 Dec 2008 00:07:51 -0800 (PST)
In-Reply-To: <20081229212119.GA3015@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104255>

On Mon, Dec 29, 2008 at 10:21 PM, Karl Hasselstr=F6m <kha@treskal.com> =
wrote:
> On 2008-12-29 21:15:44 +0100, Hannes Eder wrote:
>
>> What about instead of 'fail with an informative message', just issue
>> a warning that the name has been mangled. I use pathnames in patch
>> names frequently, so this would be very handy.
>
> Hmm, I'm still skeptical. Programs that try to be too clever all too
> often end up just being annoying and unpredictable.
>
>> I guess some with with more python skills needs to clean that up,
>> this is the first stuff I do in python ;).
>
> The code looks OK -- but as I said, I don't agree with what it's
> trying to do.
>
> There's a small inconsistency: you fail if the name contains "..", bu=
t
> correct single bad characters.

".." is used to denote patch name ranges [<patch1>..<patch2>] for
commands like "stg pop", "stg push", and so forth, therefore I think
it is wise to exclude ".." from single patch names [<patch3>].

> And as I recall, stgit.namelength is about the automatically generate=
d
> patch names -- there's no limit for the names provided by the user.

Ok.

Maybe we should start defining what a 'valid' patch name has to look
like, i.e. define

def is_patch_name_valid(patchname)

Best,
Hannes
