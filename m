From: Greg Price <price@MIT.EDU>
Subject: Re: [PATCH 4/6] rebase: --rewrite-{refs,heads,tags} to pull refs
	along with branch
Date: Tue, 28 Jun 2011 07:19:07 -0400
Message-ID: <20110628111907.GV5771@dr-wily.mit.edu>
References: <cover.1309133817.git.greg@quora.com> <c2d11ffe876a540b6fad46e2ecc57a24018cfb73.1309133817.git.greg@quora.com> <4E08ABBB.9060009@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 13:20:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbWLZ-0001OH-Sy
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 13:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676Ab1F1LUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 07:20:04 -0400
Received: from DMZ-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.37]:42319 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756749Ab1F1LTL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 07:19:11 -0400
X-AuditID: 12074425-b7b82ae000000a2a-4a-4e09b889d505
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1C.A4.02602.988B90E4; Tue, 28 Jun 2011 07:18:33 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id p5SBJ9V7007675;
	Tue, 28 Jun 2011 07:19:09 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p5SBJ7XU016795;
	Tue, 28 Jun 2011 07:19:08 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4E08ABBB.9060009@cisco.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsUixG6nrtu5g9PPoG+LrEXXlW4mi4beK8wW
	p45+Z3Vg9pjyeyOrx8VLyh6fN8kFMEdx2aSk5mSWpRbp2yVwZbSeucxW8Ii5YsvPWYwNjD+Z
	uhg5OSQETCR+r+hihLDFJC7cW8/WxcjFISSwj1Fi79HrzBDOBkaJlnttUM4XRon2ueeBHHYO
	FgFViReOIM1sAgoSP+avYwaxRQTkJZomXQRbwCxgLbHs9DMWEFtYIFbi04PLrCA2r4CxxKTm
	PnaIkdMZJV4emAmVEJQ4OfMJC0SzlsSNfy+BBnEA2dISy/9xgIQ5BTQlpp3/wQoSFhVQkVi1
	NHMCo+AsJM2zkDTPQmhewMi8ilE2JbdKNzcxM6c4NVm3ODkxLy+1SNdCLzezRC81pXQTIziU
	XVR3ME44pHSIUYCDUYmHl2klh58Qa2JZcWXuIUZJDiYlUd7ObZx+QnxJ+SmVGYnFGfFFpTmp
	xYcYJTiYlUR4pxoB5XhTEiurUovyYVLSHCxK4rwh3v99hQTSE0tSs1NTC1KLYLIyHBxKEry2
	24EaBYtS01Mr0jJzShDSTBycIMN5gIZvB6nhLS5IzC3OTIfIn2JUlBLnrQFJCIAkMkrz4Hph
	qeYVozjQK8K8y0GqeIBpCq77FdBgJqDBZbVgg0sSEVJSDYxTjj3VC/jRVZQhHh2XIlxtuff7
	z+ll/ivSFTc85L+x5oJ1z/bZsdyxTlcsHlzsvBq0SEFp5tt12x6L6hWL9zDyL00wUp7Uv3HL
	q8MlqW7ly6d9DFrxQy9lhvfji/JNxl9EmHr+C8vdrg69O+fvnS/NvTXdnCeMWZaH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176393>

On Mon, Jun 27, 2011 at 12:11:39PM -0400, Phil Hord wrote:
> On 11/18/2009 06:51 PM, Greg Price wrote:
> > @@ -96,6 +99,7 @@ state_dir=
> >  # One of {'', continue, skip, abort}, as parsed from command line
> >  action=
> >  preserve_merges=
> > +rebase_refs=
> >  autosquash=
> >  test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
> I think you meant to spell that "rewrite_refs=" instead of "rebase_refs=".

Ha, so I did.  Fixed.  Thanks!

Greg
