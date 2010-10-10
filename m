From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 11/14] daemon: report connection from root-process
Date: Sun, 10 Oct 2010 21:31:02 +0200
Message-ID: <AANLkTinz69u-hh-URqBrpdcrm+84N2BC7Ov4O8xeuW73@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-12-git-send-email-kusmabite@gmail.com> <201010102058.16773.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: msysgit+bncCOPdven-DxCNqcjlBBoE5cv_TA@googlegroups.com Sun Oct 10 21:31:53 2010
Return-path: <msysgit+bncCOPdven-DxCNqcjlBBoE5cv_TA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qw0-f58.google.com ([209.85.216.58])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCNqcjlBBoE5cv_TA@googlegroups.com>)
	id 1P51cb-0004jG-I6
	for gcvm-msysgit@m.gmane.org; Sun, 10 Oct 2010 21:31:49 +0200
Received: by qwb7 with SMTP id 7sf2692087qwb.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 10 Oct 2010 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received-spf:received:received:mime-version:received
         :reply-to:in-reply-to:references:from:date:message-id:subject:to:cc
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=LcixEkGGjHTtSEIlZjchP7JfYX7RWPoup1W6vNDvQBM=;
        b=kvcehIFMjbgC+QTogudNe7T4mRj2frwNhKtp/iM8pkaWMnuX5BDQzLPkufP27Ljso5
         KpVjXzZsuowyiSSpQwf1xpXga2UiVFykUgh6xD0/CocoEveLHCZYf70yCuG/hCkY4Mrz
         4ufJHbUuM+VLLPfuNcsMIqdY8N7gv84Oxmh0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        b=nrJ33kZ1KbANanpfLFoJ89FoCvA7bfwPY2NpalmBi6P/tuc2zIYrRXsRcxC8Scgbal
         zIFvXdZayC4s+3nixI1NxbOCtVoyQ/27Sg4PL8nNfZmZE5w20sXnO8hNXNsG7Q5TUXn0
         LfhdXH4SVfsS+9OGkkbcExnCohvUdo6G5q7+g=
Received: by 10.229.44.3 with SMTP id y3mr273167qce.13.1286739085269;
        Sun, 10 Oct 2010 12:31:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.229.207.84 with SMTP id fx20ls615149qcb.0.p; Sun, 10 Oct 2010
 12:31:24 -0700 (PDT)
Received: by 10.229.191.133 with SMTP id dm5mr812998qcb.27.1286739084321;
        Sun, 10 Oct 2010 12:31:24 -0700 (PDT)
Received: by 10.229.191.133 with SMTP id dm5mr812997qcb.27.1286739084288;
        Sun, 10 Oct 2010 12:31:24 -0700 (PDT)
Received: from mail-vw0-f41.google.com (mail-vw0-f41.google.com [209.85.212.41])
        by gmr-mx.google.com with ESMTP id 3si2715033qci.6.2010.10.10.12.31.23;
        Sun, 10 Oct 2010 12:31:23 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.41 as permitted sender) client-ip=209.85.212.41;
Received: by mail-vw0-f41.google.com with SMTP id 19so1575999vws.14
        for <msysgit@googlegroups.com>; Sun, 10 Oct 2010 12:31:23 -0700 (PDT)
Received: by 10.220.201.77 with SMTP id ez13mr1634978vcb.78.1286739083076;
 Sun, 10 Oct 2010 12:31:23 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 12:31:02 -0700 (PDT)
In-Reply-To: <201010102058.16773.j6t@kdbg.org>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.41 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158687>

On Sun, Oct 10, 2010 at 8:58 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Sonntag, 10. Oktober 2010, Erik Faye-Lund wrote:
>> Report incoming connections from the process that
>> accept() the connection instead of the handling
>> process.
>>
>> This enables "Connection from"-reporting on
>> Windows, where getpeername(0, ...) consistently
>> fails.
>
> Is this from the process that you invoke with --serve? then this failure could
> be due to Winsockets not being initilized. Did you check that?
>

I've tried that, and unfortunately it lack of socket initialization
does not seem to be the reason :(
