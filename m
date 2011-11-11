From: David Michael Barr <davidbarr@google.com>
Subject: Re: [PATCH 0/14] resumable network bundles
Date: Sat, 12 Nov 2011 00:13:07 +1100
Message-ID: <CAFfmPPN=f2nL4NAbhnHhkKvMFpgi2B+DeUQ42Si+do=Z4_SAXQ@mail.gmail.com>
References: <20111110074330.GA27925@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 11 14:13:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROquw-0000Tp-5s
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 14:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757827Ab1KKNNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 08:13:09 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61104 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330Ab1KKNNI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2011 08:13:08 -0500
Received: by gyc15 with SMTP id 15so2853722gyc.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 05:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=TREHi1jX2Q4Hp5I15tk7DsMd7gSdLzCZ7mt+XXA+ZoM=;
        b=VWGWNSXF/HzHFYh1PJJMKTLiKjmge66pUO4hztiBuwmGS/q8gx1vdTomhxxsRsMs0a
         5LwZoMpMgUNw1yuRc6eg==
Received: by 10.101.42.17 with SMTP id u17mr5820496anj.7.1321017187683;
        Fri, 11 Nov 2011 05:13:07 -0800 (PST)
Received: by 10.101.42.17 with SMTP id u17mr5820489anj.7.1321017187514; Fri,
 11 Nov 2011 05:13:07 -0800 (PST)
Received: by 10.100.225.6 with HTTP; Fri, 11 Nov 2011 05:13:07 -0800 (PST)
In-Reply-To: <20111110074330.GA27925@sigill.intra.peff.net>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185267>

On Thu, Nov 10, 2011 at 6:43 PM, Jeff King <peff@peff.net> wrote:
> One possible option for resumable clones that has been discussed is
> letting the server point the client by http to a static bundle
> containing most of history, followed by a fetch from the actual git r=
epo
> (which should be much cheaper now that we have all of the bundled
> history). =A0This series implements "step 0" of this plan: just letti=
ng
> bundles be fetched across the network in the first place.
>
> Shawn raised some issues about using bundles for this (as opposed to
> accessing the packfiles themselves); specifically, this raises the I/=
O
> footprint of a repository that has to serve both the bundled version =
of
> the pack and the regular packfile.
>
> So it may be that we don't follow this plan all the way through.
> However, even if we don't, fetching bundles over http is still a usef=
ul
> thing to be able to do. Which makes this first step worth doing eithe=
r
> way.
>
> =A0[01/14]: t/lib-httpd: check for NO_CURL
> =A0[02/14]: http: turn off curl signals
> =A0[03/14]: http: refactor http_request function
> =A0[04/14]: http: add a public function for arbitrary-callback reques=
t
> =A0[05/14]: remote-curl: use http callback for requesting refs
> =A0[06/14]: transport: factor out bundle to ref list conversion
> =A0[07/14]: bundle: add is_bundle_buf helper
> =A0[08/14]: remote-curl: free "discovery" object
> =A0[09/14]: remote-curl: auto-detect bundles when fetching refs
> =A0[10/14]: remote-curl: try base $URL after $URL/info/refs
> =A0[11/14]: progress: allow pure-throughput progress meters
> =A0[12/14]: remote-curl: show progress for bundle downloads
> =A0[13/14]: remote-curl: resume interrupted bundle transfers
> =A0[14/14]: clone: give advice on how to resume a failed clone
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

I just want to say thank you for doing this.--David Barr
