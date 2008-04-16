From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: crlf with git-svn driving me nuts...
Date: Wed, 16 Apr 2008 22:56:54 +0100
Message-ID: <320075ff0804161456h1a6fd4e8qdd185f4540a1259a@mail.gmail.com>
References: <320075ff0804161210m46f3e83bpf7bf9d1d5816d914@mail.gmail.com>
	 <20080416200107.GG3133@dpotapov.dyndns.org>
	 <32541b130804161320w42c68bc2p9d838dc127a57027@mail.gmail.com>
	 <20080416203923.GH3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 23:57:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmFdP-0001DB-9J
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 23:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754147AbYDPV44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 17:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754529AbYDPV44
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 17:56:56 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:42367 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834AbYDPV4z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 17:56:55 -0400
Received: by fk-out-0910.google.com with SMTP id 19so2999807fkr.5
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QMG87ZjQKD6fo/RK7+cXjT7IJbses5b3d0Ii4D3Ejf4=;
        b=SN3g+ejbjIt+lBVLiYdSrrttv01GX+qZmvSOyKp5T3657U2NcCO+w+au8eeQS8d1IOu97m1t+1oQB388rQW+9IsaXOXt+pfcsjMVW3Qag8MiRpcYaUYPRbxrvqPfcRNV+638bQJzCrk7mSydiqmlsbkwsRh1P0qEd6OQYryYeXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AuoHu/6NKrmnxwuA7fLLey2r0VGyHur/3uGsf+u2LqOgaKrOrrVI6aj9I0kpLS70CMSoXXuym+6IQapGlzXdJi2MczPqdWvfrEmXyCm4cqV1p0TAFdrE19dj+5hnLpTPgLmJ7tayj3QM7K8kfSZ8NNKnOtSrNuZvZyxVEqVcG6Q=
Received: by 10.82.146.10 with SMTP id t10mr789012bud.87.1208383014340;
        Wed, 16 Apr 2008 14:56:54 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Wed, 16 Apr 2008 14:56:54 -0700 (PDT)
In-Reply-To: <20080416203923.GH3133@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79758>

>  > Nigel's example showed a few situations where git *thought* the file
>  > had changed when it hadn't, and yet is incapable of checking in the
>  > changes.
>
>  Incapable of checking in? I have not found a single example in
>  his mail where it was impossible. The only quirk with autocrlf
>  is that you need to re-checkout your work tree after changing
>  it. There is no other problems with it as far as I know.
>

My (initial) setting of core.autocrlf to false was because that's what
it was on all the windows clients (I know the default has now changed)
and to make the later parts of the script obvious that the file in the
repo had a CRLF ending, rather than have being converted to LF. That's
the situation we have, because they've all come from SVN.

The bit I really don't understand is why git thinks a file that has
just been touched has chnaged when it hasn't, and doing a 'git reset
--hard' actually doesn't help at all (but, bizzarely, git config
core.autocrlf false & git config core.autocrlf true *does* !). The
repo copy is CRLF, the working copy is CRLF, but git thinks it's
changed...
