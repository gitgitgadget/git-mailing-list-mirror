From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 17/20] refs: allow ref backend to be set for clone
Date: Tue, 19 Jan 2016 12:06:01 -0500
Organization: Twitter
Message-ID: <1453223161.16226.24.camel@twopensource.com>
References: <1452857550-25887-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jan 19 18:06:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLZjP-0006Ke-3O
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 18:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995AbcASRGI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jan 2016 12:06:08 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34630 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755297AbcASRGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 12:06:04 -0500
Received: by mail-qg0-f51.google.com with SMTP id 6so505541500qgy.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 09:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=GoPLNPL/I3xC0B23yEJRAQVFbh9lGgPZbqwwPcqNyCs=;
        b=NRQmyWwHrf+h1g0GAgoh+3WruiKzuQmRjfqBtjCtUD9p0YGJclID32jnzB2xDPs09j
         d1hCPhQDhilWfGf1ZyFzV0wVPR5OEFbuNwIHwHq4c519jS3BbiupFBynAbfsG8/wr1Px
         jANWDCMyXrdle4NJWoXHAclhazdckqHL0lYUtymQE/jweM2dOwQq6Bt++OFS/PEzu8VS
         5YDC3J2OQVXtu2mlc1vv8w1pcB80MVQ07BrfdeU31aY623cWfdMyzF3rdr8nZoUe0SuU
         4XyAEScjTtiB+QN/114R9Y8uAQy6mE6VLHKXzQiAfMHEHcdNHooJ4Hj5COMt/aIBAyMu
         2OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=GoPLNPL/I3xC0B23yEJRAQVFbh9lGgPZbqwwPcqNyCs=;
        b=UHlWM5fuqYVaqLONUwCccwxFGhu4oV7DFvU0YftsW9+xjXGlOWaRE0wCJDE363FIqf
         2tb/9fchaZbQ8dA9wFB4Ooa9+ZbqBJ78wzrTk1NCpmWh/WJB5APvjG/JVbMrfaQBQW35
         Fbgcf7U+XX8Jmax/w1GBJgLCUizuV92zU5lBJ+EsR1tyY4t73DaKPZR5NIHoujBcn5PZ
         ooVUCLFKd5i05v3gm6NPBBAV1sY7gB+O6XZbBkH3IapVxoPptSEGGYkrtsMnB18odUrO
         aC5fpZg/UyYc9BycctdMC6OFkQkoWgqp1q70NpWefd6ELcW+k/YC3EHlfJvecDJc5EDy
         b7mw==
X-Gm-Message-State: ALoCoQl4WChlT541jEb60Avja/M1BFhCnSAiUopir81qcLy5pxh2nw/Hh9mGirShEEqGL3BtGOz+AxF+6gK6PXp3XBoCNDiS2A==
X-Received: by 10.140.140.80 with SMTP id 77mr41501173qhm.61.1453223163211;
        Tue, 19 Jan 2016 09:06:03 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id o2sm12594113qkl.15.2016.01.19.09.06.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jan 2016 09:06:02 -0800 (PST)
In-Reply-To: <1452857550-25887-1-git-send-email-szeder@ira.uka.de>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284360>

Thanks for the suggestions.

With your permission, I will add:

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>

to all three of these patches post-squash.  Is that OK?

On Fri, 2016-01-15 at 12:32 +0100, SZEDER G=C3=A1bor wrote:
> Hi,
>=20
> This change is more about 'git clone' than about refs, therefore
> I think the subject line would be better as:
>=20
>   clone: allow setting alternate ref backend
>=20
> Could you please squash this in to keep the completion script up to
> date?
> Is there or will there be a way to list available ref backends, so we
> could complete possible options for --ref-storage=3D<TAB>, too?
>=20
> ------ >8 ------
>=20
> Subject: completion: git clone --ref-storage=3D
> ---
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index ab4da7f97917..c970d3c0d0a3 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1092,6 +1092,7 @@ _git_clone ()
>  			--depth
>  			--single-branch
>  			--branch
> +			--ref-storage=3D
>  			"
>  		return
>  		;;
>=20
