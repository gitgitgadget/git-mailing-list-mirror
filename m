From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not call built-in aliases from scripts
Date: Fri, 28 Jun 2013 13:43:31 -0700
Message-ID: <7vr4fmm0ek.fsf@alter.siamese.dyndns.org>
References: <CAHGBnuNUjaWH2UDsa6jGjf32M+b8-iezw4pKXR985mROFSLOKQ@mail.gmail.com>
	<alpine.DEB.1.00.1306272030291.28957@s15462909.onlinehome-server.info>
	<CAHGBnuOE6vYzM2bKs2SV1qJVoCOX=t-XWnd_Xbs1JRD+sY4dVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Git Mailing List <git@vger.kernel.org>,  msysGit Mailinglist <msysgit@googlegroups.com>,  Thomas Braun <thomas.braun@virtuell-zuhause.de>,  Pat Thoyts <patthoyts@users.sourceforge.net>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRB5XKW6HAKGQEW2MQWNQ@googlegroups.com Fri Jun 28 22:43:36 2013
Return-path: <msysgit+bncBCG77UMM3EJRB5XKW6HAKGQEW2MQWNQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f189.google.com ([209.85.213.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB5XKW6HAKGQEW2MQWNQ@googlegroups.com>)
	id 1UsfW3-0006sa-Tx
	for gcvm-msysgit@m.gmane.org; Fri, 28 Jun 2013 22:43:36 +0200
Received: by mail-ye0-f189.google.com with SMTP id l14sf386286yen.26
        for <gcvm-msysgit@m.gmane.org>; Fri, 28 Jun 2013 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:x-pobox-relay-id
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type;
        bh=uiIp/KfWbeFIfFepl6svY0GuKAxSuFfxc/E3yYfMBcI=;
        b=AeK8aH63GeVdzsp0UtpdStdm09AydztjQuz0WpsJAafrrtbJFMLUyLfzoHBO9KS2i/
         RNEy5YqXHce3kWhteeQiWa04x3l9PEupOFLU/1zwNj3t+MIeQDkntNstG/hDManWLZPM
         t8VQ9vlwinJ6m/QNtZNQf5EblV8qZAh9qEcbigJq0JjOf9xqErHibwYGIiA9uUS5gJY0
         hm7HhzZ50l77ngcmYMn9/dfiq47kkGMaaPZFG2poMwVqKdgVy4TakzEwmKJuihG7c2rX
         CDn3v5XNgvqlh9detJP6eX2Jhl58yQmHeCQdnrqMNx2TnIUHh5NZQoD/Wqrwrqruc910
         gp 
X-Received: by 10.49.101.78 with SMTP id fe14mr406773qeb.13.1372452215087;
        Fri, 28 Jun 2013 13:43:35 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.122.6 with SMTP id lo6ls1379913qeb.63.gmail; Fri, 28 Jun
 2013 13:43:34 -0700 (PDT)
X-Received: by 10.58.29.1 with SMTP id f1mr1848804veh.34.1372452214246;
        Fri, 28 Jun 2013 13:43:34 -0700 (PDT)
Received: from smtp.pobox.com (b-pb-sasl-quonix.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id k12si492365vdd.2.2013.06.28.13.43.34
        for <msysgit@googlegroups.com>;
        Fri, 28 Jun 2013 13:43:34 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD7392C46F;
	Fri, 28 Jun 2013 20:43:33 +0000 (UTC)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2A392C46E;
	Fri, 28 Jun 2013 20:43:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48C8D2C46C;
	Fri, 28 Jun 2013 20:43:33 +0000 (UTC)
In-Reply-To: <CAHGBnuOE6vYzM2bKs2SV1qJVoCOX=t-XWnd_Xbs1JRD+sY4dVQ@mail.gmail.com>
	(Sebastian Schuberth's message of "Fri, 28 Jun 2013 22:23:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6601E0B0-E033-11E2-8719-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of junio@b-sasl-quonix.pobox.com
 designates 208.72.237.35 as permitted sender) smtp.mail=junio@b-sasl-quonix.pobox.com;
       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229237>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Thu, Jun 27, 2013 at 8:52 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
>>> --- a/git-merge-octopus.sh
>>> +++ b/git-merge-octopus.sh
>>> @@ -97,7 +97,7 @@ do
>>>       if test $? -ne 0
>>>       then
>>>               echo "Simple merge did not work, trying automatic merge."
>>> -             git-merge-index -o git-merge-one-file -a ||
>>> +             git merge-index -o git-merge-one-file -a ||
>>
>> This is a problem. 'git-merge-one-file' cannot be split here AFAICT.
>>
>> Of course, we could teach merge-index to read *two* parameters instead of
>> one when it encounters "git" as the <merge-program>. But that would be as
>> hacky as the whole dashed-form business to begin with.
>
> I agree to all of your comments except this one: I did not split
> 'git-merge-one-file' here ...

I do not think Dscho was pointing out any problem with your patch.

He is merely pointing out that the goal of "No git-foo anywhere on
the filesystem" is an unworkable one, as sometimes you need to give
the path of a specific binary to commands.  It is not limited to the
"-o" option of "git merge-index", but the above is a good example.

And I agree with Dscho that this is not a problem with your patch
per-se.

>>>       echo "Simple merge failed, trying Automatic merge."
>>> -     if git-merge-index -o git-merge-one-file -a
>>> +     if git merge-index -o git-merge-one-file -a
>>
>> As above, with -octopus.
>
> Sorry, I can't follow you here.

The same issue above, that you have to have "git-merge-one-file"
somewhere in your filesystem on $GIT_EXEC_PATH, he pointed out when
he commented on the patch to git-merge-octopus.sh, can be seen here.

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
