From: Matt Graham <mdg149@gmail.com>
Subject: Re: Git performance results on a large repository
Date: Fri, 3 Feb 2012 23:05:40 +0000
Message-ID: <CALts4TT49VAWPZ6XO9qahDTu=2E425QcRvXx5-75Jv8n4yp8RA@mail.gmail.com>
References: <CACBZZX4BsFZxB6A-Hg-k37FBavgTV8SDiQTK_sVh9Mb9iskiEw@mail.gmail.com>
	<CB5179E9.3B751%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 00:05:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtSCR-0005X1-V8
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 00:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab2BCXFm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 18:05:42 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34184 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab2BCXFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 18:05:41 -0500
Received: by yenm8 with SMTP id m8so1858718yen.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 15:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=10BT2xAmcIV/ojSBvHOAZYJ304Nc1Q/trbgUqAEdjJA=;
        b=pOwoQjSNBts81P3a7dexPO5fJFdk+HtqCYINUnueCVLTYW0tx83ysJ/XshVr8yY54q
         P7wrzsTB/IgzMuqFZ24I+bDntBffJVbWM80unOU6r/UHH0GEcVNdD6EHzZZUV8hRY92a
         cbNcVFtDo91B17lK21l0SxtBXXTM2Gz2C5t6U=
Received: by 10.236.126.168 with SMTP id b28mr12815492yhi.88.1328310341021;
 Fri, 03 Feb 2012 15:05:41 -0800 (PST)
Received: by 10.146.157.21 with HTTP; Fri, 3 Feb 2012 15:05:40 -0800 (PST)
In-Reply-To: <CB5179E9.3B751%joshua.redstone@fb.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189824>

Hi Josh,

On Fri, Feb 3, 2012 at 17:00, Joshua Redstone <joshua.redstone@fb.com> =
wrote:
> Thanks for the comments. =C2=A0I've included a bunch more info on the=
 test repo
> below. =C2=A0It is based on a growth model of two of our current repo=
sitories
> (I.e., it's not a perforce import). We already have some of the easil=
y
> separable projects in separate repositories, like HPHP. =C2=A0 If we =
could
> split our largest repos into multiple ones, that would help the scali=
ng
> issue. =C2=A0However, the code in those repos is rather interdependen=
t and we
> believe it'd hurt more than help to split it up, at least for the
> medium-term future. =C2=A0We derive a fair amount of benefit from the=
 code
> sharing and keeping things together in a single repo, so it's not cle=
ar
> when it'd make sense to get more aggressive splitting things up.
>
> Some more information on the test repository: =C2=A0 The working dire=
ctory is
> 9.5 GB, the median file size is 2 KB. =C2=A0The average depth of a di=
rectory
> (counting the number of '/'s) is 3.6 levels and the average depth of =
a
> file is 4.6. =C2=A0More detailed histograms of the repository composi=
tion is
> below:

Do you have a histogram of the types of files in the repo?
And as suggested earlier, is svn working for you now because it allows
sparse checkout?  I imagine the stats for svn on the full repo would
be comparable or worse to what you measured with git?
