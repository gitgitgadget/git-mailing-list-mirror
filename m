From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/3] cache-tree: Create/update cache-tree on checkout
Date: Tue, 01 Jul 2014 12:15:26 -0700
Organization: Twitter
Message-ID: <1404242126.6112.7.camel@stross>
References: <1404173597-24713-1-git-send-email-dturner@twitter.com>
	 <53B23605.40705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 01 21:15:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X23Wx-0007o9-HN
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 21:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427AbaGATPr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jul 2014 15:15:47 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:45040 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbaGATPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 15:15:46 -0400
Received: by mail-qg0-f44.google.com with SMTP id j107so3824042qga.17
        for <git@vger.kernel.org>; Tue, 01 Jul 2014 12:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=3cP5KIIkNSGbt1EVOmq6RPY9q9QPtZYK7Tu4fO0yHX8=;
        b=Ctb1iOZYwTseTrSTYjG1G2BKcd1mDR/N8MAZaIf+7lfU/PVrV7ySs+TrTmNtPlPzOy
         opcR0cv48VaTZdUC3SFKDz5Ax7dYk8b2Dxxe7gwKj5bUKrdA/B6KG6ycYCvNMDfEwwpx
         dyZkEv4N+cKW/hcgnFVD7Bzw93MvQJrzSxIMmNBbVFLETLmwIBzSRKCyyfRlxkveID5c
         UxPjH0qO/4QHJYIdh8psj5x0LquAYIjM1MQD164SHOi1g3P8fh6kv3XYHg/zFbF9TB77
         Y6mzXhP2Lk+44dnKZ68nmSVLr/A3wvdwog8TT3j+4yDlrI9peFo2TeWDOneuQd8qA4b7
         rZjQ==
X-Gm-Message-State: ALoCoQl8IDsHU+woWc/gyvDBjErX7LRovmdjeV1IjraWEVnBcKJFlkothC5kMPpkOx0wWv5gkz+r
X-Received: by 10.140.29.139 with SMTP id b11mr71173785qgb.44.1404242145792;
        Tue, 01 Jul 2014 12:15:45 -0700 (PDT)
Received: from [172.25.140.220] ([8.25.197.27])
        by mx.google.com with ESMTPSA id o111sm8410362qgo.44.2014.07.01.12.15.44
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 01 Jul 2014 12:15:45 -0700 (PDT)
In-Reply-To: <53B23605.40705@web.de>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252736>

On Tue, 2014-07-01 at 06:16 +0200, Torsten B=C3=B6gershausen wrote:
> diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
> index 6c33e28..7c60675 100755
> --- a/t/t0090-cache-tree.sh
> +++ b/t/t0090-cache-tree.sh
> @@ -85,9 +85,22 @@ test_expect_success 'reset --hard without index gi=
ves cache-tree' '
>   	test_shallow_cache_tree
>   '
>  =20
> -test_expect_failure 'checkout gives cache-tree' '
> +test_expect_success 'checkout gives cache-tree' '
> +	git tag current
>   	git checkout HEAD^ &&
>   	test_shallow_cache_tree
>=20
> The && chainis broken here.
> Does the test now pass, because "git tag" is added ?

The tag does not cause the cache-tree to be created, so git tag does no=
t
cause the test to pass.
