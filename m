From: =?UTF-8?B?VmlsbGUgU2t5dHTDpA==?= <ville.skytta@iki.fi>
Subject: Re: [Bash-completion-devel] [PATCH v2] completion: add new git_complete
 helper
Date: Sat, 21 Apr 2012 20:39:30 +0300
Message-ID: <4F92F0D2.1090609@iki.fi>
References: <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com> <7vaa2by8nj.fsf@alter.siamese.dyndns.org> <20120416160729.GM5813@burratino> <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com> <20120416200941.GD12613@burratino> <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com> <20120416203320.GF12613@burratino> <CAMP44s0Q2A_oKJx27ct9W__KVQkQxzst3H7gq6sZDhrCLDQaag@mail.gmail.com> <20120416204641.GH12613@burratino> <CAMP44s23_Qx3R9TX4frM-JYNv7XT3eVbcZ_D45nEdh0rq-O8kA@mail.gmail.com> <20120416205952.GJ12613@burratino> <4F925FBC.2030406@iki.fi> <CAMP44s1dNqokGuLg3ReLAreNBM++0NxOMUUk-=AgFBUy3n=E9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	bash-completion-devel@lists.alioth.debian.org, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 19:39:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLeHe-0001F0-Fg
	for gcvg-git-2@plane.gmane.org; Sat, 21 Apr 2012 19:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376Ab2DURjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Apr 2012 13:39:36 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:60234 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751147Ab2DURjg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Apr 2012 13:39:36 -0400
Received: by lahj13 with SMTP id j13so8178138lah.19
        for <git@vger.kernel.org>; Sat, 21 Apr 2012 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=kCtDI++Lm0hIb1amFvJQ7UFehPFNB4XegOVT7DBN/Uw=;
        b=Mn1HtmgkjefkE7iTK4oqW60cLfngVqaBrwzj7R6MkbkAWJbDjLtP32czRdg39cwZwM
         qxbkL2k/POY28LkcTpGnu/edZv0lruhECL8CcegUtFuBgyIH1WKIfYMLOA0F5/LuwR2o
         AADhV5EUSmxono/z1+/knJprC3voQ4b6rOdyhuzc60lUaLmSSLf3lhI2sUnqsId6Vpi+
         H8I5eemF4OXDe72djPLzXRSjXrAUVljYSUngEIPSCnoK/qEyJbIOIMB43thdJ+t550TH
         mWk1Sr839sP6aqbMEo8qwhkfynr/Q6pM2Wid2PMFqa+Wt0ioZAP7CAXEpY+i7mwxn4/d
         QtWw==
Received: by 10.112.86.231 with SMTP id s7mr4878608lbz.11.1335029974326;
        Sat, 21 Apr 2012 10:39:34 -0700 (PDT)
Received: from michael.steam.fi (cs78200229.pp.htv.fi. [62.78.200.229])
        by mx.google.com with ESMTPS id pj20sm9616097lab.13.2012.04.21.10.39.31
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Apr 2012 10:39:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <CAMP44s1dNqokGuLg3ReLAreNBM++0NxOMUUk-=AgFBUy3n=E9w@mail.gmail.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196054>

On 2012-04-21 18:41, Felipe Contreras wrote:

> Still, I don't see the point in avoiding 'git_complete' and making our
> lifes more difficult.

I'm not aware of ways it'd make people's lifes more difficult, but if
git_complete is a function intended for completion purposes, I'd
personally not name it git* because it'd interfere for example with
completing git<TAB> by being included in the suggested completions even
though it's never meant to be used that way.  Prefixing for example with
underscore doesn't avoid the problem completely, but makes it less
likely to happen.
