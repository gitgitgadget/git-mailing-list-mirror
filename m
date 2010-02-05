From: Steve Diver <squelch2@googlemail.com>
Subject: Re: Implement --password option for git svn perl script
Date: Fri, 05 Feb 2010 23:01:15 +0000
Message-ID: <4B6CA33B.8050200@googlemail.com>
References: <a362e8011001290617n326a9dcx7c345ec31dff4ebe@mail.gmail.com> <001636ed7681994278047e4e4a6f@google.com> <a362e8011001290618g542be5f5y2777a925ba9bd936@mail.gmail.com> <1976ea661001290704h3ed4761dscf95ba848b373555@mail.gmail.com> <be6fef0d1002012015q2a10af1cq4c5e5f968039ee45@mail.gmail.com> <1976ea661002012030h23aa415ek30aa6db23cb88d0e@mail.gmail.com> <a362e8011002012237t640dd8b9sa1da0d221f5d03b6@mail.gmail.com> <20100202090538.GA28437@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Laszlo Papp <djszapi@archlinux.us>, Frank Li <lznuaa@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Feb 06 00:01:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdXB7-00020r-9v
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 00:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933959Ab0BEXB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 18:01:28 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45010 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933916Ab0BEXB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 18:01:27 -0500
Received: by vws20 with SMTP id 20so1422687vws.19
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 15:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=3uyfT3SwuvdMxESldkTfUlDxenjTsZMzADJnfbyEVeU=;
        b=TDVNMN/MGLS8NRqq5yaZ1ngUys4cAntR0cLI2qCgQ8YiHP8ZB9wdqXABywT6leL4bs
         9iGAQGiacgEYKwQQhIDCntPEoaSyL9hrDyeNSFZi1zQx2434sgOeUJek616eoJpMWXKm
         i58eTXNLeomIeD/xsSNlAXSi/KYaK8GY6ldPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=d3544Hvba2JR/Vbj1VP3oRQSk6voRZdeT0dV61sXzNUCaZnlvzORPDaNkDknKUr4kQ
         1W/YnyMHdYczjhu/fpnyqVJWstmvQLNnVypgC2n/C9CiCMgtE3jdpcfwGJXG3X+d1KOQ
         ObuDgRlC8r1ANhJiXcXGET3xPeUjNG7UHJMsI=
Received: by 10.220.83.91 with SMTP id e27mr3981119vcl.113.1265410886381;
        Fri, 05 Feb 2010 15:01:26 -0800 (PST)
Received: from ?10.0.0.16? ([89.241.110.215])
        by mx.google.com with ESMTPS id 24sm15883353vws.13.2010.02.05.15.01.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 05 Feb 2010 15:01:24 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <20100202090538.GA28437@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139107>

On 02/02/2010 09:05, Eric Wong wrote:
>
> Laszlo Papp<djszapi@archlinux.us>  wrote:
>>> The basic requirement is git svn can provide a way to prompt a dialog
>>> box to input passwd.
>>
>> Yeah, it's a very basic use case, but I don't know whether there is a
>> workaround for it somehow, maybe perl gurus or git svn users could
>> help more...
>>
>> My company, where there are windows users (95% of the company), would
>> like to use TortoiseGIT as a graphical client for SVN server
>> repositories as an SVN client, no other way by us, so it'd be high
>> priority :) So I've got a beer for any volunteer, thanks :P
>
> Hi, (fixed subject so I don't mistake it for junk again)
>
> I don't know (and have no way to test) how to deal with input dialogs
> for reading a password on Windows (nor any sort of IPC).  Somebody else
> will have to implement it.
>
> Having a --password option in the command line could work, but it's
> painfully insecure if there's any way for another regular user to view
> the process table.  Not something I'd like to encourage...
>
> Since SVN already caches passwords in a mostly secure location on disk
> (at least on *nix), shouldn't git svn be able to use the password cache
> SVN uses?
>

Tortoise, along with at least one other Windows GUI utilizes the Putty 
suite as a helper app for key chain and password handling, and needs to 
be loaded prior to any SSH operations. Tortoise have gone so far as to 
rewrite plink (Tortoiseplink.exe)so that that a prompt for the password 
is given, but this is undocumented AFAIK.

Otherwise, it is an unfortunate fact that a DOS console session is 
invoked whenever openSSH is used. For the average Windows user this is a 
scary occurrence, and is one of the obstacles that prevents wider casual 
take up of Git on Windows IMHO.

I understand that it comes down to a problem with communication between 
a dialogue and an SSH client via STDOUT. I believe Dscho might have some 
insight into this as it is a recurrent topic on the MsysGit tracker.

Steve
