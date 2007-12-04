From: Salikh Zakirov <salikh@gmail.com>
Subject: Re: [RFC] Introduce .git/BRANCH to point to the current branch
Date: Wed, 05 Dec 2007 06:57:06 +0900
Message-ID: <4755CD32.7040204@gmail.com>
References: <4755B3B3.80704@gmail.com> <vpqbq96jjrf.fsf@bauges.imag.fr> <m34peyur8r.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 22:57:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izfll-0007xt-AG
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 22:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbXLDV5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 16:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbXLDV5N
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 16:57:13 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:19559 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbXLDV5M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 16:57:12 -0500
Received: by an-out-0708.google.com with SMTP id d31so938900and
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 13:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=R5+EaF8VXhd9EylNRZ5M4IG6PYI1/OXI67av2O/bACU=;
        b=Eo1FyMC0qLIsGzcb3zY+zXfh9cC02i5zpqMDskkeiAN7zgCDaIsjOLc5znK5G+9C78ytW0bHhWv3lAkq1gph/9GXqyumo4iukCah9Fyw//KDBvHObfEUNLP4aGmhYgdmkLWLvsskg0N/bQtfAcHHFE+PAt25zfm2RpajFPYqG5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=tVZXxGErtD1a2rbdsO+1xNPYqhAUyuVaQQG819w4Fe2O8s2tcEOUV54O8+ZiuBtXu74HV2TQg4iq5zaDcGd66Yy9HB1A+XEeo/tnziC+9ZXWYwBPE27Tn6AR5YuAY2kO6qFWR/wZIwkbFOzg52FJRqLqeCEs178omQUE2380sxc=
Received: by 10.100.249.9 with SMTP id w9mr2378430anh.1196805431452;
        Tue, 04 Dec 2007 13:57:11 -0800 (PST)
Received: from ?221.115.75.108? ( [221.115.75.108])
        by mx.google.com with ESMTPS id e27sm127115elf.2007.12.04.13.57.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 Dec 2007 13:57:10 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20070819)
In-Reply-To: <m34peyur8r.fsf@roke.D-201>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67086>

Jakub Narebski wrote:
>> Salikh Zakirov <salikh@gmail.com> writes:
>>> This combination leads to the confusing user experience
>>> if the branch changes independently of the working directory.
>>> This can happen in following cases:
> 
> All those cases are cases of not recommended workflows.

I guess those cases are not recommended exactly because
there are prone to causing confusion with current git.

I use multiple workdirs quite often, and by now learned
not to check out the same branch in different workdirs, 
but it would very convenient if it would not be necessary to remember it.

> Please search the archives for idea of BASE extension to index
> (instead of your separate file under .git/refs), and why it is
> not in current git.

I never realized this idea has been already tried. Thanks for the pointer!
I would try to use BASE extension.

> BTW. how in your proposal would you detach HEAD?

Deleting .git/BRANCH should be enough.
But I cannot see the workflow that would need it.
If one checks out older state of the branch, there is no harm in maintaining
the BRANCH pointer, as commits done in this state need to be manually merged in order
to get into the branch, in the same way as detached head works currently.
