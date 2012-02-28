From: Jon Jagger <jon@jaggersoft.com>
Subject: Re: git (commit|tag) atomicity
Date: Tue, 28 Feb 2012 17:12:54 +0000
Message-ID: <CADWOt=ig5=Bhhkjs9-wbm2djtwWPOfPGtYt9pH-U3YuQ+iyXzg@mail.gmail.com>
References: <CADWOt=j8gJvr88eNAfoYq_qGQvG6M_k-9MCuof_DRrH0sHRVCA@mail.gmail.com>
	<4F4D04F4.80905@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 18:13:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Qbk-00063e-K5
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 18:13:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015Ab2B1RM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 12:12:56 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:36474 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753734Ab2B1RMz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 12:12:55 -0500
Received: by obcva7 with SMTP id va7so7009232obc.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 09:12:55 -0800 (PST)
Received-SPF: pass (google.com: domain of jrbjagger@googlemail.com designates 10.182.149.71 as permitted sender) client-ip=10.182.149.71;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jrbjagger@googlemail.com designates 10.182.149.71 as permitted sender) smtp.mail=jrbjagger@googlemail.com; dkim=pass header.i=jrbjagger@googlemail.com
Received: from mr.google.com ([10.182.149.71])
        by 10.182.149.71 with SMTP id ty7mr7027357obb.70.1330449175024 (num_hops = 1);
        Tue, 28 Feb 2012 09:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=PoyDhywJgapUAv6FFdfo+2cN1KdHs2JrWBpO6l+IN8Y=;
        b=a1uhxLXjJ86Hhgp/aI47651H910xUc35BjafxXOsQIkxmlzX3iykLcMMOf0OWiq45U
         PFoqTJY27bYnL/Pa2DwIL4wxRtBpQj200U/rcbJab9Z+3MYp0KDcFuDgdQmIVjXwiYwh
         Cx2iuYtFH/vg3sWikoXPKzAsYKSBP06p8CisA=
Received: by 10.182.149.71 with SMTP id ty7mr6241094obb.70.1330449174983; Tue,
 28 Feb 2012 09:12:54 -0800 (PST)
Received: by 10.182.133.40 with HTTP; Tue, 28 Feb 2012 09:12:54 -0800 (PST)
In-Reply-To: <4F4D04F4.80905@ira.uka.de>
X-Google-Sender-Auth: undvXyZrt4zDTxaZCNlZmgnk1L8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191744>

On Tue, Feb 28, 2012 at 4:46 PM, Holger Hellmuth <hellmuth@ira.uka.de> =
wrote:
> On 28.02.2012 16:40, Jon Jagger wrote:
>>
>> Hi,
>> I don't know a lot about git - I use it as a tool behind
>> http://cyber-dojo.com
>> which is an online coding dojo server.
>> I have a quick question...
>> If I do a
>> =A0 =A0git commit ....
>> in one thread and a
>> =A0 =A0git tag | sort -g
>> in another thread is the output of the git tag guaranteed to be atom=
ic?
>
>
> Can a "git commit" add or remove tags? AFAIK it can't and so the two
> commands don't conflict in any way.

Sorry, I failed to ask the question I really wanted to ask...

I mean in one thread
   git tag -m 'AAA' BBB HEAD
and in another thread
   git tag | sort -g

and the question is whether the output of the git tag|sort -g command
is guaranteed to be from before the git tag -m... or from after the
git tag -m... but not "interleaved" in any way....

Cheers
Jon
