From: "Vinubalaji Gopal" <vinubalaji@gmail.com>
Subject: git-svn and SVK mirror between two repositories
Date: Thu, 24 May 2007 10:04:46 -0700
Message-ID: <7d8fb81e0705241004u1c52fa7aub42d3793d4bfeaa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 19:04:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrGk8-0003mZ-DR
	for gcvg-git@gmane.org; Thu, 24 May 2007 19:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbXEXREs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 13:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750696AbXEXREs
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 13:04:48 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:32077 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbXEXREr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 13:04:47 -0400
Received: by wr-out-0506.google.com with SMTP id 76so164179wra
        for <git@vger.kernel.org>; Thu, 24 May 2007 10:04:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=t+RwXnVvO6WOJMKH9CQhp5qwasyGTsToHIxT/mkVF99rXJJ6XQI2e5K8BJx4GlFUhbEoPoZsEEVlZd3JdQ3TPoAp/rTi2IW2tM1ENkB/gUOKCiArcf2BiZvIMCMs25EB5RmuHbm8vSxLcotBpN3zOMopk/eChZ6z64eA5fta+PM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EZhCEpuSX5JyDFXWHfCR6vpT/WF33AlHuk9ZVPGTllH5osyoPBYrTjtOpXOBm9tvuhEolPo3N65kv3Z00YgsZ2ALoufH3GNb0fN8hfJF54DWH8gGNlOSWVdsM0+uDlRUuDBsT+8aZXfH1zGcBbz9Ka9Ek/uydkjuUaHGoH5W8bs=
Received: by 10.115.33.1 with SMTP id l1mr1022390waj.1180026286314;
        Thu, 24 May 2007 10:04:46 -0700 (PDT)
Received: by 10.115.55.16 with HTTP; Thu, 24 May 2007 10:04:46 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48275>

Hi all,
    I have been trying hard to find if it is possible to mirror (or
clone in git-svn terms) two svn repositories and update changes from
one to other or do even more complex operations with these two
repositories. I did check the git-svn man page, but was lost without a
proper example. Can someone please provide me with an example of using
two svn repositories in git-svn and doing merge operations, etc .

I have used SVK for a long time and it was very much possible to use
two svn repositories using the SVK FAQ entry as shown below:

Repository ONE in Paris, repository TWO in London and be able to
create 2 mirrors then smerge both, doing it on a node in Berlin and
using the mirror function?
Sure. Simply do this:

svk mirror svn://svn.paris.fr/ //paris
svk mirror svn://svn.london.uk/ //london

# pick a sensible base, or use --baseless
svk smerge --base=1234 //paris //london

# ... and smerge between them normally ...
svk smerge -I //london //paris
svk smerge -I //paris //london



-- 
Vinu

In a world without fences who needs Gates?
