From: "Vegard Nossum" <vegard.nossum@gmail.com>
Subject: Re: [PATCH 1/3] Modified test-lib.sh to output stats to /tmp/git-test-results
Date: Mon, 12 May 2008 16:55:22 +0200
Message-ID: <19f34abd0805120755w5d2361d9y86d4b3ba26b2befa@mail.gmail.com>
References: <1210584832-16402-1-git-send-email-srabbelier@gmail.com>
	 <1210584832-16402-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, dsymonds@gmail.com
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 16:56:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvZRk-00016a-2i
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 16:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYELOzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 10:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751686AbYELOzX
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 10:55:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:33788 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYELOzW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 10:55:22 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2698843rvb.1
        for <git@vger.kernel.org>; Mon, 12 May 2008 07:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0Q8vXDFASlMljBuoL165zPWwgtZmCVYgjeBbdRyCjbk=;
        b=NGhjdLypLRAgSWuxYFar9pts6O9mUKh2WQXqPr3g3LNE2qZ9mEEg4YfVESs42Un9WKDXYL1AW7uHqRimXLUfENoVqS9jC6Zf9ckQGfqCGz47mLOxgkF7C2JZUQZPSC2W4RKdrzmxE1j3WsyX9xqs+zuDdzkBSiUiGoT7x7ClOIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WffkAVlSwmtfhzmwGag+TgBLjM0Rz3dOom9hdrxN3JALCBKJ0uxhqddxzt0Td/BxX8CPvJoBaAz2Ac2kTFwy11I/QbnMYjuEbYNZZJnHyxpagn/bZMEFmwJGphnMBu5nvk3ltI78xGD99cF3daHPDOdpFbagnYo5p2etVFmFow4=
Received: by 10.140.249.20 with SMTP id w20mr3736074rvh.21.1210604122069;
        Mon, 12 May 2008 07:55:22 -0700 (PDT)
Received: by 10.141.185.13 with HTTP; Mon, 12 May 2008 07:55:22 -0700 (PDT)
In-Reply-To: <1210584832-16402-2-git-send-email-srabbelier@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81869>

Hi!

On Mon, May 12, 2008 at 11:33 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> This change is needed order to aggregate data on the test run later on.
>  Because writing to the current directory is not possible, we write to /tmp/.
>  Suggestions for a better location are welcome.

I have seen this in another (sh) script:

die() {
        echo "$@"
        exit 1
}

T=`mktemp` || die "cannot create temp file"
...
rm $T


Vegard

-- 
"The animistic metaphor of the bug that maliciously sneaked in while
the programmer was not looking is intellectually dishonest as it
disguises that the error is the programmer's own creation."
	-- E. W. Dijkstra, EWD1036
