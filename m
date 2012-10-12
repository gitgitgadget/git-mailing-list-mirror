From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How can I tell if anything was fetched?
Date: Fri, 12 Oct 2012 08:28:30 +0200
Message-ID: <5077B88E.5060303@viscovery.net>
References: <CAFRB3XkueafikCvwzBb+WOAG_1mEkVg1Yt6=teOuVwYd2zWVOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Phil Lawrence <prlawrence@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 08:28:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMYjm-0002vz-Rr
	for gcvg-git-2@plane.gmane.org; Fri, 12 Oct 2012 08:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425Ab2JLG2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2012 02:28:36 -0400
Received: from so.liwest.at ([212.33.55.24]:14010 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755014Ab2JLG2f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2012 02:28:35 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TMYjX-0008L2-4X; Fri, 12 Oct 2012 08:28:31 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B713A1660F;
	Fri, 12 Oct 2012 08:28:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAFRB3XkueafikCvwzBb+WOAG_1mEkVg1Yt6=teOuVwYd2zWVOw@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207530>

Am 10/11/2012 18:25, schrieb Phil Lawrence:
> What is the best way to know whether or not anything was received
> during the fetch?  I don't want to be stuck trying to parse the answer
> out of STDOUT and STDERR...

what="--all"	 # or "--remotes=the-remote"
presha1s=$(git rev-parse $what)
git fetch the-remote
if test -z "$(git rev-list -1 $what --not $presha1s)"
then
	echo nothing new
fi

Error checking is left as an exercise for the user ;)

-- Hannes
