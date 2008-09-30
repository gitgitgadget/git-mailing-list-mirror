From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: Re: [PATCH] git-gui: Do not automatically stage file after merge tool finishes
Date: Tue, 30 Sep 2008 12:00:57 +0400
Organization: HOME
Message-ID: <200809301200.57353.angavrilov@gmail.com>
References: <48E1CA7F.5050501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 30 10:12:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkaCv-0000eP-H5
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 10:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbYI3ICd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 04:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbYI3ICd
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 04:02:33 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:2223 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbYI3ICc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 04:02:32 -0400
Received: by ik-out-1112.google.com with SMTP id c30so1393030ika.5
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 01:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=krXbwdEIiXUu/RiASsX9b3kyMTBzAMoQ33k0xjL0SY0=;
        b=e+DPx0DCficQKooCE8MfUXHvILU4qUvCEXpjFmXLJTMv1/RLa9qXbODFfum2EPSxFN
         jD2CWpS4gEvENLP1dcsRx6AyuSg5rqlEtn+VJULuFsRdndHo5Hgaw4iYs64JqCuyjDgk
         YwsvZibkxz0ZY4nO5IWQ3IoX4/Hc6jWlZH15w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FQuMMLGMS6Sh31iJiwrfazSAGAGzzOPDoX7MQTceC/vATuidNP+60LxnyaugADKZGe
         s4Gek1vLK7AhtzI/ez/YED5y3FxwrybPKIW5wG+CDaLMr5pILHB6AHhAkaNrmkXhXW12
         gozpmWq6jJdiRy1rl0nSh/QohB6XKV/3NM/WA=
Received: by 10.103.222.12 with SMTP id z12mr4591507muq.12.1222761750352;
        Tue, 30 Sep 2008 01:02:30 -0700 (PDT)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id e8sm3690203muf.6.2008.09.30.01.02.27
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 30 Sep 2008 01:02:28 -0700 (PDT)
User-Agent: KMail/1.10.1 (Linux/2.6.26.3-29.fc9.i686; KDE/4.1.1; i686; ; )
In-Reply-To: <48E1CA7F.5050501@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97077>

On Tuesday 30 September 2008 10:43:11 Johannes Sixt wrote:
> From: Johannes Sixt <johannes.sixt@telecom.at>
> 
> If a merge tool was invoked on a conflicted file and the tool completed,
> then the conflicted file was staged automatically. However, the fact that
> the user closed the merge tool cannot be understood as the unequivocal
> sign that the conflict was completely resolved. For example, the user
> could have decided to postpone the resolution of the conflict, or could
> have accidentally closed the tool. We better leave the file unstaged and
> let the user stage it explicitly.
> 
> Since the file is not staged anyway, the check for an unmodified
> timestamp is pointless and removed.
> 
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  I had sent this patch last week (but marked as RFC). Here it is again
>  without 'RFC' because I think it is a necessary change.

Now that the issue with staging of working copy files is more or less
resolved, I agree that it is better to disable automatic staging.

Alexander
