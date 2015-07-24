From: Sven van Haastregt <svenvh@gmail.com>
Subject: Re: Arrow keys broken in gitk
Date: Fri, 24 Jul 2015 20:39:33 +0100
Message-ID: <55B29475.6010902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Roland Lutz <rlutz@hedmen.org>
X-From: git-owner@vger.kernel.org Fri Jul 24 21:39:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIiou-0006Jl-1f
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 21:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbbGXTjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 15:39:43 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35547 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbbGXTjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 15:39:42 -0400
Received: by wibxm9 with SMTP id xm9so41964476wib.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :in-reply-to:content-type:content-transfer-encoding;
        bh=rLGMO4D4EZWpZnonBgqoMWx0e9mZ7Kj0FVTXhDdbN0c=;
        b=u8B0hYg8Bp9b87UzbO+/H2aM2ebSMWQUoiJmVyTWf0U1nNsx4xIYen5zFODaGySsVA
         jmyy1NSZh1x2G2WIUpTG1HFw77X+3wtSmBelHbsLvdJWT8hq2GgjqADM/xNP20WVu2lY
         oAE4xZqjworvXRkDXdCDDjxZqLZYDwpgFcVb5qHe5V9A/jBjfyBNUWPNu+m+ydZLkn/t
         m7MIbHwunFkfmJK5W2Q328AuR3zZ/opA53Zarl7+IWuOOaPF/KVG3xZQp/k3Ablv81jt
         wFfQOsNFj0Gp//vbOP0PCGIl/dOy07B8o34Qw0ra8IezpQoU2RAgpJFO33/kWD5+H1qo
         nTQw==
X-Received: by 10.194.201.71 with SMTP id jy7mr31202017wjc.93.1437766781570;
        Fri, 24 Jul 2015 12:39:41 -0700 (PDT)
Received: from [192.168.1.70] ([80.189.82.216])
        by smtp.gmail.com with ESMTPSA id l14sm14117331wjq.21.2015.07.24.12.39.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jul 2015 12:39:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: alpine.DEB.2.11.1503281637160.7351@nimbus
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274592>

Roland Lutz <rlutz <at> hedmen.org> writes:
 > in gitk on Debian jessie (Git version 2.1.4), the left/right arrow
 > keys don't work in the text input fields.  When I click into the SHA
 > ID field or either search field and press the left or right arrow
 > key, nothing happens.  I'd expect the text cursor to move one
 > character forward or back.

Confirming the problem with Tk 8.6 for git 2.4.6.  The <home> and <end> 
keys are also affected inside text fields.  Running gitk with Tk 8.5 
(i.e., wish8.5) gives the expected behaviour.

It seems changes to the text and entry widget bindings in Tk 8.6 are 
causing the problem.  Quoting http://wiki.tcl.tk/22115 :

``The text widget's default bindings seem to have changed pretty 
considerably - a lot of things are now handled via custom events instead 
of direct bindings (notably things which move the cursor and alter 
selection)''

Sven
