From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-add has gone lstat() mad
Date: Sat, 31 Mar 2007 16:09:21 +0100
Message-ID: <200703311609.23309.andyparkins@gmail.com>
References: <200703302055.13619.andyparkins@gmail.com> <200703311119.10581.andyparkins@gmail.com> <86lkhdqx8y.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 17:12:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXfFp-0005kC-KL
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 17:12:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753152AbXCaPMP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 11:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753153AbXCaPMP
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 11:12:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:8775 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbXCaPMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 11:12:14 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1097774uga
        for <git@vger.kernel.org>; Sat, 31 Mar 2007 08:12:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QE4WeL6SU2Z/tkD/KDkofxp5IDIBvCFRTM9QCfHiAbBzx3yOQUXXhOjXStuAyxbvNU48lCE+HOI/VyrSLC+NqHvDa3CHlwrXIPNwG7WpGzDni0hvXb6MNYBNoiy8wZ/6Aotk7R/bDlHz5SHShlt/Rl+JR5HB5x1xO0WIGCVES6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mpvi3xbowsPHxlbJfzANNILIDbHj/O76JdBIBHsAt07VBrpG8crOuNtKkvN/4eSkYX6L5o7pYQbFibV1ckrNzr4LECZWxKjfDcpecHDnlna+vvKJb23Lc7sbJ90oYY6JAHFGJH7Iuiz3G5TQiYm8NDpBn9mwvrUXg9+BWol0Ey8=
Received: by 10.67.44.8 with SMTP id w8mr2823045ugj.1175353933323;
        Sat, 31 Mar 2007 08:12:13 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id q40sm4645533ugc.2007.03.31.08.12.12;
        Sat, 31 Mar 2007 08:12:12 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <86lkhdqx8y.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43560>

On Saturday 2007, March 31, Randal L. Schwartz wrote:

> Given that git currently doesn't maintain any metadata other than
> +x/-x, how are you maintaining the metadata for your homedir items? 
> I know some schemes were discussed here in the past, but I'm curious
> as to what you settled on. For example, your .netrc file needs to be
> 600, but git won't track that.

I'm not maintaining anything as yet; the experiment so far consists 
of .bashrc only :-)

Just storing my .inputrc, .bashrc, .vimrc and .gitconfig in a repository 
is probably going to give me all that I want.  There aren't many other 
config files that I regularly update, and certainly not many that I 
update differently on different machines.

However, I plan to use a script to wrap the git calls so that I don't 
have to type GIT_WORK_DIR and GIT_DIR for every file I want to track.  
I plan to make it so that if you run this script with a checkout or 
other working tree changing command then I will run a function within 
it that reads the metadata out of a file that is stored in the 
repository which will restore those settings.

Ideally this functionality would be in hooks for pre-update-index and 
post-checkout-index or similar.  But I have a feeling that the 
potential for conflicts makes it hard to do in reality.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
