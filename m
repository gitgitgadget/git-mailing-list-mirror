From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: GIT get corrupted on lustre
Date: Wed, 23 Jan 2013 16:23:14 +0100
Message-ID: <CABPQNSad1EKbmt3Gjs+uB9fud4YBqmk++5GMqF2s047Lcc8GwQ@mail.gmail.com>
References: <50D861EE.6020105@giref.ulaval.ca> <50D870A0.90205@interlinx.bc.ca>
 <50EC453A.2060306@giref.ulaval.ca> <50EDDF12.3080800@giref.ulaval.ca>
 <50F7F793.80507@giref.ulaval.ca> <CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
 <50F8273E.5050803@giref.ulaval.ca> <871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
 <50F829A9.7090606@calculquebec.ca> <871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
 <50F98B53.9080109@giref.ulaval.ca> <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
 <87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org>
 <87r4lejpx8.fsf@pctrast.inf.ethz.ch> <50FF051D.5090804@giref.ulaval.ca> <878v7keuh3.fsf@pctrast.inf.ethz.ch>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>, git@vger.kernel.org,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?ISO-8859-1?Q?S=E9bastien_Boisvert?= 
	<sebastien.boisvert@calculquebec.ca>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 23 16:24:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty2Bf-0003sF-G9
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 16:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab3AWPX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 10:23:57 -0500
Received: from mail-ie0-f182.google.com ([209.85.223.182]:41811 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755710Ab3AWPXz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 10:23:55 -0500
Received: by mail-ie0-f182.google.com with SMTP id s9so13886772iec.13
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 07:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=3G89k6s77p5kR5UB/kJiA7Kle20baAVwab9YJOVnCYc=;
        b=rkSGPW7+YZawMfbGvgXWpzi/RQlqBQZ2lxXxWoiWi/ILg5c/mOF7hXUuzZ+pt+xG9H
         gDkMYlWKn0qpmgzRF563YAQ5eltuNAq2VjfIS1eyweuMpLVtQz7PCggIUKSYK6Jos/Fn
         2QrzW8k/H61+rhMAobFfIc5UrcGv/pbH8lbdgGKZ0RthU2BoeeGvmkFZ5/mqUbavaX9I
         Lk+CxU+MC5U/cf6IwRGOAYKkmVjyhH1joOSvE9IK9Rn9DVYW4ig45LEmCZ7z2RaietyN
         5MFlbOsQT9ELvjwdXunPOjpcCxM2oj9kt9ju1pxCQG8GvADScOtWg4sfgpWQLYOKmmE4
         xksA==
X-Received: by 10.50.51.231 with SMTP id n7mr15158666igo.85.1358954634207;
 Wed, 23 Jan 2013 07:23:54 -0800 (PST)
Received: by 10.64.9.112 with HTTP; Wed, 23 Jan 2013 07:23:14 -0800 (PST)
In-Reply-To: <878v7keuh3.fsf@pctrast.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214326>

On Tue, Jan 22, 2013 at 11:14 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:
>
> Other than that I agree with Junio, from what we've seen so far, Lustre
> returns EINTR on all sorts of calls that simply aren't allowed to do so.

I don't think this analysis is 100% accurate, POSIX allows error codes
to be generated other than those defined. From
http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_03.html:

"Implementations may support additional errors not included in this
list, *may generate errors included in this list under circumstances
other than those described here*, or may contain extensions or
limitations that prevent some errors from occurring."

So I don't think Lustre violates POSIX by erroring with errno=EINTR,
but I also think guarding every single function call for EINTR just to
be safe to be insane :)

However, looking at Eric's log, I can't see that being what has
happened here - grepping it for EINTR does not produce a single match.
