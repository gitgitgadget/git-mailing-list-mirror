From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: 'commit -a' safety (was: Re: Please default to 'commit -a' when 
	no changes were added)
Date: Sat, 24 Apr 2010 12:57:18 -0700
Message-ID: <r2j8c9a061004241257ma6ad8fa6uec9498d3fe16e409@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <m3633hdw9u.fsf_-_@localhost.localdomain> 
	<AC853FF9-6723-4824-BB2C-E7E8F79AA95E@wincent.com> <20100424164247.GM3563@machine.or.cz> 
	<alpine.LFD.2.00.1004241430300.7232@xanadu.home> <20100424185433.GN3563@machine.or.cz> 
	<r2y8c9a061004241235n77ca3925q8fde8fc3b01e4e80@mail.gmail.com> 
	<alpine.LFD.2.00.1004241539270.7232@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Wincent Colaiuta <win@wincent.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Goswin von Brederlow <goswin-v-b@web.de>,
	578764@bugs.debian.org, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Apr 24 21:57:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5lU0-00040D-MF
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 21:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752971Ab0DXT5j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Apr 2010 15:57:39 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49898 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab0DXT5i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Apr 2010 15:57:38 -0400
Received: by pxi17 with SMTP id 17so1213778pxi.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5UC9vTZSLfHVGSavUxzO6qHMR9uBNueLpvRH+kdwipo=;
        b=NZr5g1fZLZ+HGHMwxAof5ihigEqi/ithXvznqJj5TyEmi6O3wUPLnjlYCBU/adnd71
         /vNPd8LntxfX24YOAKs6KyihkEjAWxmQf9R0iZ8YHjgY+oJj7zlv5rIObiK2e7tTVbIj
         0giwPSivPUgIte0lwnJDNay41zqspN0BEbd6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=miQBseZcDHc7m4WTzAYjA9fJCODaWxosZ159Dv9vY8HnK1/Bg9YrRG7kuaQwH4w9Mk
         n4apy+4SlVsVlVDIYNfvG2UXCuyozRO6G4dA1UVWCjfhRPzgo4ZROtJPIQtjoOQiqIkC
         IJOP9Zd7lYU1BgchoXL6EC0yaxYfLFCyWwjkQ=
Received: by 10.142.210.11 with SMTP id i11mr917535wfg.196.1272139058140; Sat, 
	24 Apr 2010 12:57:38 -0700 (PDT)
Received: by 10.142.141.12 with HTTP; Sat, 24 Apr 2010 12:57:18 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1004241539270.7232@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145701>

On Sat, Apr 24, 2010 at 12:44, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 24 Apr 2010, Jacob Helwig wrote:
>
>> On Sat, Apr 24, 2010 at 11:54, Petr Baudis <pasky@suse.cz> wrote:
>> > Are there valid user scenarios where you customize your index, the=
n want
>> > to override that using -a without thinking twice?
>> >
>>
>> Depends on what you consider "customizing your index". =C2=A0I add f=
iles to
>> the index all the time as I'm working on things, then commit -a at t=
he
>> end "without thinking twice".
>>
>> For example:
>> 1) Hack on something.
>> 2) git add $thing
>> 3) Run full test-suite.
>> 4) Fix a failing module.
>> 5) git add $fixed-module-and-tests
>> 6) Repeat 3-5 until there's only one module failing.
>> 7) Fix last failing module.
>> 8) git commit -a
>>
>> I doubt I'm the only one that stages things as a way of marking them
>> as "done", and using git commit -a to "check-off" the last "todo"
>> item.
>
> Sure. =C2=A0But do you happen to often "commit -a" more changes to an=
 already
> previously modified and staged (but not committed yet) file?
>

It's not uncommon.  It's not the 90% case, either.

Specifically, I'd do this if I needed to make additional changes to a
file that I originally thought was "done", while working on that last
failing module.
