From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: What's cooking in git.git (Aug 2009, #05; Wed, 26)
Date: Thu, 27 Aug 2009 13:02:09 -0500
Message-ID: <tK_IWVRokJuwYhAJ3h5cvYFUGHzmrYoRPbMxLQUdj2eLINK_28NnVA@cipher.nrlssc.navy.mil>
References: <7vfxbeb0mt.fsf@alter.siamese.dyndns.org> <SW-k_fUnLrE0kFNXSIYgMIc-pexuL5ykWs1ZdvHAo9_LMxe9ggJtCA@cipher.nrlssc.navy.mil> <7vr5uxrwld.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 20:02:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgjIj-0003x1-AD
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 20:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbZH0SCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 14:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZH0SCK
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 14:02:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53748 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZH0SCK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 14:02:10 -0400
Received: by mail.nrlssc.navy.mil id n7RI29at029652; Thu, 27 Aug 2009 13:02:09 -0500
In-Reply-To: <7vr5uxrwld.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 27 Aug 2009 18:02:08.0998 (UTC) FILETIME=[7EAA9860:01CA2740]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127182>

Junio C Hamano wrote:
> Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
> 
>>> This seems to break t9001.  Near the tip of 'pu' I have a iffy
>>> workaround.
>> Can you squash this into your 'iffy' workaround to help platforms
>> (Solaris 7, IRIX 6.5) without the 'yes' utility?
> 
> Not in this form, for two reasons ;-)
> 
> (1) t7610-mergetool.sh,also seems to use "yes".  Perhaps define something
>     in test-lib.sh?
> 
> (2) The implementation is iffy.

Looks good, I'll rework it sometime if you don't beat me to it.

-brandon



>> +yes () {
>> +	test -n "$*" && y="$*" || y='y'
> 
> Shouldn't it be
> 
> 	if test $# = 0
>         then
>         	y=y
> 	else
>         	y="$*"
> 	fi
> 
> so that
> 
> 	yes ""
> 
> would give runs of empty lines?        
