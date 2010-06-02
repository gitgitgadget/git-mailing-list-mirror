From: John Tapsell <johnflux@gmail.com>
Subject: Re: git locate
Date: Wed, 2 Jun 2010 14:00:27 +0900
Message-ID: <AANLkTim6cLkr5BFTRTh2nZGwsfVgHZi3M-b9IER8dHf3@mail.gmail.com>
References: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
	<alpine.DEB.1.00.1001200224270.4985@pacific.mpi-cbg.de>
	<m3zl49bk0o.fsf@localhost.localdomain>
	<alpine.DEB.1.00.1001201021060.31129@intel-tinevez-2-302>
	<4B579BA8.8050000@gmail.com>
	<fabb9a1e1002150520v29cf8d59ke27cde3e9697b011@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 07:01:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJg5L-0007jZ-Jl
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 07:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767Ab0FBFA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 01:00:29 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42882 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab0FBFA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 01:00:28 -0400
Received: by pxi18 with SMTP id 18so2282523pxi.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 22:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type;
        bh=bq+EEJ7E1A+iGWGY4G+x0cvvZhm9gi47qWkqAVGE1fc=;
        b=W4qMq1jp05bHKXAroVRIUhajribI8b86gZ+EXfR8VoT5Qa4qT7D3SBTMctA6oi471F
         BByEKGuhSpDxl+TqZvkRRcQVHOcpLxogAjZkUj+uAplGlOlHdy17Ngj2L5NyEXDRyLSV
         YGZYZNOeCOWghUPu3g4VJfMVkqkwcXN+k73nA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=k3peyXcy5t8hTFVeIKb4VsSzBJvMOAmP8pPzhPV3PC3umzgbJsapUD4aEdi0bMUryF
         TBAp/K+d3qvqIV6WfxXYOISJGjfZpY6gqyFBY0JuBilpof4r2hALWDNKAy6FdJYKDNrp
         uXa4e7gMQh02ds8c5USywUMiNE+3lj3m7Jxno=
Received: by 10.114.187.37 with SMTP id k37mr6327982waf.37.1275454827183; Tue, 
	01 Jun 2010 22:00:27 -0700 (PDT)
Received: by 10.115.79.12 with HTTP; Tue, 1 Jun 2010 22:00:27 -0700 (PDT)
In-Reply-To: <fabb9a1e1002150520v29cf8d59ke27cde3e9697b011@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148200>

On 15 February 2010 22:20, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Thu, Jan 21, 2010 at 01:11, SungHyun Nam <goweol@gmail.com> wrote:
>> The alias 'git locate' and the command 'git ls-files' runs
>> differently if I run them in a subdirectory.
>> Is it expected?
>
> I just ran into this (I wanted to alias 'git find' but to me the 'run
> ls-files from cwd' is desirable. Also, I prefer to have a trailing
> glob as well, so I added one :). An easy solution is to drop
> 'git-find' in your path somewhere:

I have finally settled on:

[alias]
    locate = !sh -c 'git ls-files | grep --color=auto "$1"' -

This acts as if there is a leading and trailing wildcard, and also
colors the output nicely.

Can we add this as default please?  There didn't seem to be any
resistance in this thread to making it default, just that nobody did
it :)

John
