From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] crlf: Add test showing double warning on commit
Date: Sun, 15 May 2016 08:39:31 +0200
Message-ID: <55965a71-7078-60ad-0746-6f677dbb3f06@web.de>
References: <20160514111755.GG2345@dinwoodie.org>
 <baea5604-e786-5773-aa68-f311efb23752@web.de>
 <xmqqoa887a25.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun May 15 08:39:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1piP-00047u-F6
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 08:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbcEOGjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 May 2016 02:39:41 -0400
Received: from mout.web.de ([212.227.15.3]:52094 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbcEOGjk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 02:39:40 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MaajJ-1bHZBE0k6T-00KCBO; Sun, 15 May 2016 08:39:33
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
In-Reply-To: <xmqqoa887a25.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:2A6TDnSDdHQBJy/gHmx3RwW66FPii4CJxAoBWyfq8iFB57hij85
 XiualdqRdbq1x3o4VQFl/rnPgUTgkWc/9JSvcDKHL+qDQvipG3DMJM9V/pNswoEre3j0bCM
 tu69ust2Mkwbq0FZORF+lqhXHDav/MGnOr7No7MPX4+mWjbdn9e4b0/zsTiUVTpp1CyVydM
 +8E23jGvxd31OHTmGsMiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J2TECANjV6s=:80Q1TVWPo8m+rvMYmhrtHl
 t37VgIRiasVfAHs8lUD6RrwE2ytfH1C+tTOfy6dSZa1Kbg4MlRiVAYHIcsH20t2K2zWrIv0B1
 SdOVxbrcTXHdX7gb2FmOG+0ibapHosCEw34SjRh1NJXZTdYnVXYJrD1XfGE6yShOnOPrn90n9
 5hZbfcfiBjTQ5t1KN8rhTDakNX0sgZTWckZP6jBGnptfsYij5oztBPizA+117O5miRiIoCLU/
 3spmLh4830XojFVzlR1e7Z//jPRa/6YjWLkbfCv0DsrGQ+WTHG+zZ7uA4mRzRK9NqAWT0vb+2
 df3d5jbcxYZEjSuPTK6f6t5AzmqXsGH7I6Qk066HLWy+htthOub5dNG4ij2N2SXo7jGmehGas
 QhVbnD8Gd5ksqy3ZQuwwH7EkIJOQ/OMOjL+SwnCzN/2lVcC5AEXsCgLnTq6pCCJijLB68rLuy
 6rAe4PVXcl+4WCu2cVqAQCY4OMQwTw+EN+ko5jQ8OTML6pD6XJyYtUttZftnIJ6EmFWNdg6oR
 /br6ZJWJ3woYMHt2y2B5/4GitWwumKnKl0xi/AwotasZRkp8f+rR8hgIxOSSeCuBM07LwuHEl
 j64383Jc8dg2B7/yRr+1rY3Yx86N0PPs0M2uiOsBkOstX7Pee2I/DZt3MDkMiSgq3xuBRs2cQ
 snFJP6Y5iT3VeQzezrfNibZaCP9SBP7z6YdEYN/VU20T8/FXB84z5ged5gGlIOrBZPhAloUxB
 qw0MAVoZDIFoSCY7bvPq4dTlNCPiGcVoic8lxrsofyVWWHRMiyqTyGgoqOa6uqyApmhk3f4A 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294641>

On 14.05.16 20:45, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> Do we need to run diff_populate_filespec() twice when src=3D=3Ddst ?
>=20
> Of course we do.
>=20
> src and dst may have the same path, but are coming from different
> places (src may be an indexed blob while dst may be a file in the
> working tree).
>=20
>> If yes, we may need to introduce a flag besides
>> #define CHECK_SIZE_ONLY 1
>> #define CHECK_BINARY    2
>> to suppress the conversion warning ??
>=20
> I do not think that belongs to diff_populate_filespec() at all.
>=20
> Why should conversion routine give this warning when called by
> diff_populate_filespec() in the first place?  Shouldn't it be silent
> by default, and is allowed to talk _ONLY_ when we are attempting to
> actually replace the data in the index, e.g. "git add" and "git
> commit -a"?
>=20

Nja, (Or Nyes in English), the old handling tried to be "nice" to the u=
ser:
$ git add text # gave warning
#User forgets, does other things, git reset HEAD....
$ git commit # Gave the warning one more time, to remind the user,=20
             # what he did, and what is really commited.

But it may be, that diff_populate_filespec() is the wrong place for spe=
aches ?
