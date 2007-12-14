From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Fri, 14 Dec 2007 04:45:23 -0800 (PST)
Message-ID: <m3fxy5qwbq.fsf@roke.D-201>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712031258460.9605@xanadu.home>
	<7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 14 13:45:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J39vL-00067k-5b
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 13:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbXLNMp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 07:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763398AbXLNMp2
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 07:45:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:34759 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbXLNMp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 07:45:27 -0500
Received: by nf-out-0910.google.com with SMTP id g13so912910nfb.21
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 04:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=kVMBReQ4f3NQP5EOnOwQxtgYGnDH9zqejL+BP+//YvU=;
        b=un03k1qIsiPgsBuM56TlZEg5ob6fyBu7rg5cp4uV3jB3GTlYL6bB1tG79HkXV9ybzCB5Z9Ifp7kBRIbc3rneDSyTY2yxy4313o4uL3em0VTsfeeKWq/27N3Xsl4hUmBgKLAuPNxIvJOzYL7drFquTtBm/xE5niqtlD5rZzMH+V8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=LV8vA3453AcoCtkQNWRW39KMeMXi4mFkhdBVuEx7MmOV7CrwrHN9Lb0tZyeeRXfC5SUhtyehzzI+EaRe8rS2+mfGy1cmT9HGOSqrgOFHJTaNMPeh247hbbmUUkLSt32cPnrpz0FgDIYKPqtG4fYw9714o2efQleg5cRsXy5e9YM=
Received: by 10.82.145.7 with SMTP id s7mr8776862bud.6.1197636325303;
        Fri, 14 Dec 2007 04:45:25 -0800 (PST)
Received: from roke.D-201 ( [83.8.245.165])
        by mx.google.com with ESMTPS id v23sm12249638fkd.2007.12.14.04.45.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Dec 2007 04:45:23 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBECjFxm004788;
	Fri, 14 Dec 2007 13:45:19 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBECjEsJ004785;
	Fri, 14 Dec 2007 13:45:14 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68300>

Nicolas Pitre <nico@cam.org> writes:

> + * From v1.5.5, the repack.usedeltabaseoffset config option will default
> +   to true, which will give denser packfile (i.e. more efficient storage).
> +   The downside is that git older than version 1.4.4 will not be able
> +   to directly use a repository packed using this setting.
> +
> + * From v1.5.5, the pack.indexversion config option will default to 2,
> +   which is slightly more efficient, and makes repacking more immune to
> +   data corruptions.  Git older than version 1.5.2 may revert to version 1
> +   of the pack index with a manual "git index-pack" to be able to directly
> +   access corresponding pack files.

Which means what? Local clone with shortcut (hardlinking and remotes)?
Dumb protocols (http, ftp, rsync)?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
