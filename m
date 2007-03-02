From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] Add git-config --remove-section, document --rename-section
Date: Fri, 02 Mar 2007 09:17:57 +0100
Message-ID: <45E7DDB5.9060009@lu.unisi.ch>
References: <es66vt$jej$1@sea.gmane.org> <Pine.LNX.4.63.0703012344270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 09:18:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN2xr-0007vq-V0
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 09:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbXCBISE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 03:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932867AbXCBISE
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 03:18:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:2301 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932865AbXCBISB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 03:18:01 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1201269nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 00:18:00 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=mwqbwEm4X6S8v7ixUlCGQbJIbNOmPlxb0ZDWuZ6rmqh20kSHhpYbe/oi3hyBDuJY+0QeuaRDcpHWKVdnpwbWB79Z96DQZNZJhSySTxXPXP9yPihEJi5bOBx4/ZGWImtkuqlWcbejr2wUYiRt+FOVvRQpZQfV+NXfFb7Nrzfije4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=dSvh2hyfs0jbojUMUfMhcOdeejBM7Nyfu97CPTI5FFexx6d/cySvtZvQr249tCqoIkG9k9N+yN7RDRzJ7jK/vVreeywOoGRmK5fns4lAUMyZ/4ZFKZY7eaXiQ147EQJOoR+6KLaKZffpD0Qxh/MUooSQbUEBtUHfoB4y8XmoIqM=
Received: by 10.49.93.13 with SMTP id v13mr7265979nfl.1172823480741;
        Fri, 02 Mar 2007 00:18:00 -0800 (PST)
Received: from ?192.168.68.211? ( [195.176.178.209])
        by mx.google.com with ESMTP id y2sm2895788mug.2007.03.02.00.17.59;
        Fri, 02 Mar 2007 00:17:59 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <Pine.LNX.4.63.0703012344270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41167>


> Am I right assuming that you copied rename_section(), and modified it to 
> be remove_section()?

Yes, after extracting section_name_match.

> How about modifying rename_section() so that if new_name == NULL, it 
> removes the section?

It's not so immediate, because rename_section has to print all the non-section lines anyway, while remove_section has to remove them too.  I agree though that there is some duplicate code in getting the filename to open.

Thanks for writing the test, having an example will make my future work easier.

Paolo
