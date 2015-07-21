From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v9 0/7] refs backend preamble
Date: Tue, 21 Jul 2015 13:20:40 -0700
Message-ID: <55AEA998.60501@alum.mit.edu>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 22:21:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHe23-0008KK-HO
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 22:20:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbbGUUUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 16:20:51 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:57297 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752110AbbGUUUu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 16:20:50 -0400
X-AuditID: 1207440d-f79136d00000402c-72-55aea99acbbb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 8E.A3.16428.A99AEA55; Tue, 21 Jul 2015 16:20:42 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6LKKfZr028787
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Jul 2015 16:20:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsUixO6iqDtr5bpQg0n/xCzmbzrBaNF1pZvJ
	gcljwfP77B6fN8kFMEVx2yQllpQFZ6bn6dslcGdMvfyXreAvZ0Xfv4oGxn/sXYycHBICJhLP
	3x9hgrDFJC7cW8/WxcjFISRwmVGi4eQ1RghnE5PE3/9NrCBVvAKaEr+6L7OA2CwCqhIfmg6B
	xdkEdCUW9TQDTeLgEBUIknj9MheiXFDi5MwnYOUiAg4Sl3cdZQYpERYwlLgzUQ4kLCTgLnHh
	xEywEk4BD4mbJzvAbmMW0JPYcf0XK4QtL9G8dTbzBEb+WUimzkJSNgtJ2QJG5lWMcok5pbm6
	uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIcHIu4Px/zqZQ4wCHIxKPLwVLWtDhVgTy4or
	cw8xSnIwKYnyVi5fFyrEl5SfUpmRWJwRX1Sak1p8iFGCg1lJhPdEJFCONyWxsiq1KB8mJc3B
	oiTOq7ZE3U9IID2xJDU7NbUgtQgmK8PBoSTBewFkqGBRanpqRVpmTglCmomDE2Q4l5RIcWpe
	SmpRYmlJRjwoGuOLgfEIkuIB2uu0AmRvcUFiLlAUovUUo6KUOO81kLkCIImM0jy4sbAU84pR
	HOhLYd4IkHYeYHqC634FNJgJaPCtWWtABpckIqSkGhid3valTpt7fGpVepf7IZOXTDPOzd++
	hJfjwY4pM581Wl9ROm/2Yk54noTVZ7GoteGGT+dktm9OkbPdcDdK0zzk8uVwDmGN+xNmKV5r
	arzE0bvSaU3iv5ywRP6ve1P+LzYzYDP/f1Bn87cJHifmZqn09357fUmnQm3ql6od 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274413>

On 07/21/2015 08:44 AM, David Turner wrote:
> This reroll addresses Michael Haggerty's comments:
> 
> - Error messages are now in the form error: reason
> - We no longer unnecessarily set errno in write_ref_to_lockfile
> - Corrected a spelling error in the new docs and another in the tests
> - Corrected some copypasta in a test.

Isn't it sobering that, every time one looks at source code, one finds
things that could be improved? (Not just yours but all source code!)
Happily it seems like the items are getting ever more trivial, and
either with or without the last round of suggestions I think the code is
correct and is a nice step forward.

Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>

Off topic: I wonder whether sooner or later we will need a

    git reflog remove <ref>

to delete an existing reference's reflog entirely without deleting the
reference and without assuming a filesystem backend. (Note that this is
different than `git reflog expire`, which leaves the empty reflog file
around and thus doesn't undo a --create-reflog.) But perhaps there is no
call for that operation. In a pinch a user could delete the reference
and recreate it to get rid of its reflog.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
