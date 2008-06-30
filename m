From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Skip unwritable tests for root
Date: Mon, 30 Jun 2008 00:39:26 -0700 (PDT)
Message-ID: <m3vdzrgymx.fsf@localhost.localdomain>
References: <1214809551-14603-1-git-send-email-ferdy@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Fernando J. Pereda" <ferdy@ferdyx.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 09:40:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDE04-0000hX-Db
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 09:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587AbYF3Hjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 03:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbYF3Hjb
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 03:39:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:48365 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbYF3Hja (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 03:39:30 -0400
Received: by nf-out-0910.google.com with SMTP id d3so403937nfc.21
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=/1c89Rt30Q8jg4fx8j0M/7RCuF6zSH2WzlqRUb8ea4E=;
        b=Lnv757lKdkMU77N0+KxZGcJ95hruCrXB7OjKHxKFUfzHeSAy8bgVFsH3P9DMLZxGVc
         99VHPPwdlpZbSdlJBOJYrfjVXk5pxSnTN767XPHiW4IcBhBXg4yDrAXQRIsV39MKmsDL
         bgE0TTdgXO87gcxsT9gtVNpR8EF6elRR0OFZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=mD319AigXYLUlZVsDgs6id41oqBnx2j4ESdx2H29ro4SreMfQqwuRoBYsCMlU8jIFX
         sfS1Py4z7I3WEQgHgx0sbTiGRMdVB33ENhd6L42QseAM1gQdsfCM99SggfPTXra1AJtD
         wGrr0+j0vEb3w91pVtu6zrQfW6dZX1D9Ig7gc=
Received: by 10.210.39.20 with SMTP id m20mr3857327ebm.49.1214811567115;
        Mon, 30 Jun 2008 00:39:27 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.210.122])
        by mx.google.com with ESMTPS id z33sm6130990ikz.0.2008.06.30.00.39.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Jun 2008 00:39:26 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5U7dLSO017282;
	Mon, 30 Jun 2008 09:39:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5U7dIMo017279;
	Mon, 30 Jun 2008 09:39:18 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1214809551-14603-1-git-send-email-ferdy@ferdyx.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86889>

"Fernando J. Pereda" <ferdy@ferdyx.org> writes:

> +if test "$(id -u)" -eq 0
> +then
> +	test_expect_success 'root writes to unwritable places, skipping test' :
> +	test_done
> +	exit
> +fi

Yet another place that would profit from test_skip in test-lib.sh...
(Junio uses "say skip" instead of "test_expect_success" in the place
like above here).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
