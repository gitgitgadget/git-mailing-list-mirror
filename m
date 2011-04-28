From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 12:08:23 +1000
Message-ID: <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
References: <4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Apr 28 04:08:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFGec-0008Bj-V2
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 04:08:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab1D1CI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 22:08:26 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45170 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab1D1CIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 22:08:25 -0400
Received: by eyx24 with SMTP id 24so687973eyx.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 19:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yGE3TBIWC/lRkXl4afgMh71gJWhg4widFuuxdq9bYDk=;
        b=mwKMBDFCjNPb9BQl6pqPL2mFDuTs8efTBG+RHjaYxVX1A2Cev9nMezPZSaTDAufX0U
         2hXViEXhZCRbTHK7gm7a566kW3uD8cnY8MhkEXuVP1QT3zo3h/nc10na4Gx70Maa6Kuy
         4/NTH9GxC+Qpx4kPD8Bfh4lVYRS4MHjRxGb2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OzXxLzkLpq2VEpb9mja0Y70bXo9CHFRMay7pc+NWV7f4MCYecKwON+9eIDh7Lt+xup
         zBHgXSaWqFAl+H7/gJnp0wDYioh/S6Q75mZqQ46PeeoQ+A1tktLnll9goJd7osd5we9Z
         sFKu7rSAL/faCyaJl7uPk26n4MMSGEGXEriaI=
Received: by 10.14.32.13 with SMTP id n13mr1359613eea.21.1303956503802; Wed,
 27 Apr 2011 19:08:23 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 19:08:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172309>

On Thu, Apr 28, 2011 at 10:55 AM,  <david@lang.hm> wrote:
> On Thu, 28 Apr 2011, Jon Seymour wrote:
>
>> On Thu, Apr 28, 2011 at 10:10 AM, Junio C Hamano <gitster@pobox.com>
>> wrote:
>>>
>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>
>>
>> I agree. Apologies for confusing things by talking too much about a
>> git pm install command.
>>
>> I think there are 3 levels of functionality. FWIW, I am suggesting
>> git-core stops at #2.
>>
>> 0. unmanaged plugins
>>
>> git doesn't provide any explicit management of plugins, but will use
>> them if finds them.
>>
>> Without some kind of management, however, you will be forced to dump
>> the man pages and scripts
>> for the plugins in one place.
>>
>> This would be very distribution manager unfriendly since there could
>> be conflicts galore.
>
> every package manager I know of has no problem with multiple packages owning
> files in one directory.
>
> if the files are named the same thing you will have a conflict, but if the
> files are named the same thing, the commands are probably going to be named
> the same, and so you will have conflicts in any case.
>

Suppose a plugin contains a file called LICENSE or README.txt. Which
LICENSE or README.txt wins?

>> I guess an unmanaged solution could use separate directories for each
>> plugin, but this would imply scanning all these paths each time you
>> invoke git. In my view, symbolic links from a dir already
>> GIT_EXEC_PATH to plugin directories would be a more efficient way to
>> do this.
>
> I think you are overanalyzing the problem

I don't think so.  Perhaps Pau can give us his view on the
desirability of a single directory for all plugins artifacts from a
distribution maintainers perspective.

>> 1. managed plugins
>>
>> git provides minimal plugin management functionality. Each plugin has
>> its own directory, but an activate step is required to make the plugin
>> available to the GIT_EXEC_PATH and GIT_MAN_PATH.
>>
>> This has the advantage that conflicts between plugins would be more
>> readily avoided and is potentially more performant. As Pau suggests,
>> this option is much more package manager friendly
>
> I don't see how this will avoid conflicts. what files are you thinking that
> the different plugins will make that won't conflict any more than the
> commands themselves will?

No, but you can manage the conflicts. Hence _managed_ plugins.

   git plugin activate

can fail with a non-zero exit code if there will be a conflict.

>
>> It probably does require a git plugin command of some kind, however,
>> in order to perform the activation step.
>
> only if you think you need a 'installed but not active' mode of operation,
> and I don't understand why you would want that.
>

For the reasons of managed conflict management.

I don't want to drop a new plugin into a common directory only to find
it has blitzed some other plugin I previously did the same with.

Still, I guess it is horses for courses.

jon.
