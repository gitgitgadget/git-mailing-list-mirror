From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] Teach git to change to a given directory using -C option
Date: Mon, 9 Sep 2013 14:43:48 -0400
Message-ID: <CAPig+cTLnMqcemMRn+fDZJDP6KH6Qn5HwKUbRViRhc60fMqfHw@mail.gmail.com>
References: <20130903115944.GA29542@gmail.com>
	<xmqq8uzdplqv.fsf@gitster.dls.corp.google.com>
	<CAEY4ZpN4xgt+gJSVeTfDNC--xt3N+M7vVLFBC7FTWBQtjvN8tw@mail.gmail.com>
	<20130904122020.GA25538@gmail.com>
	<CAPig+cRt9o=6Amhx6qTkzfk5R9aQfRZ=357BOVELm_hPsWE3WQ@mail.gmail.com>
	<CAEY4ZpNEae1UprRcpC8XUPP4XBQ89bDXP1A7yVcFdW405HZr0w@mail.gmail.com>
	<CAPig+cTNeqNhGwD-EZ3uszh5vJ4JeJ6L0RXdTsveb1FgXE5t3Q@mail.gmail.com>
	<20130909134743.GA11335@gmail.com>
	<xmqqtxhu3qil.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nazri Ramliy <ayiehere@gmail.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 09 20:43:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ6RH-0006Vw-Ac
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 20:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab3IISnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 14:43:50 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:54075 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755217Ab3IISnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 14:43:50 -0400
Received: by mail-la0-f45.google.com with SMTP id eh20so5247456lab.18
        for <git@vger.kernel.org>; Mon, 09 Sep 2013 11:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=jIgFpczp6b+trezdwSlFwtDdgEm6C6kBvYKLY/k9J0g=;
        b=AOmBmrOkqJY1y2hOAQTzFRm3E9xBVZZU1Klnrx8bswxKi3XMqrvDV+jjORvjMrf1QM
         QTF578SxqDRvmOl8sY/kOhc6Q0laYL4vmbjye54+IXwwMuECAWcL2MlGasg5k0WxklR5
         TBISICk+EwJccJKY44p/X6fNUeoi2Gs4OAucMG/lbmNsxz9wCCSFm/bh0RYJYopRWUVH
         OiFUjVNSRHlpkbY8eMLGbN5aOPsdjN3tnnd/Tnkabn/sce83vIUFi+1ry8blqZ4MLKN5
         R3Orel4gTst/vCBFjeXLhEVMjCRJzPcDqzZZlqI3Bmhk0+e2FvJ/Vz2ezWtxFIRqJsbW
         ETDQ==
X-Received: by 10.112.143.3 with SMTP id sa3mr17350993lbb.12.1378752228711;
 Mon, 09 Sep 2013 11:43:48 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Mon, 9 Sep 2013 11:43:48 -0700 (PDT)
In-Reply-To: <xmqqtxhu3qil.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: Q-jnwyNpVqmfk6EnFB1cM29JWnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234355>

On Mon, Sep 9, 2013 at 12:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     echo "initial in dir1/dir2" >expected &&
>> +     git -C dir1/dir2 commit -m "initial in dir1/dir2" &&
>
> to reduce possibilities of breaking this test in the future due to
> typos (e.g. somebody may want to say "initial commit in dir1/dir2"),
> doing this may be a better idea:
>
>         msg="initial in dir1/dir2" &&
>         echo "$msg" >expected &&
>         git -C dir1/dir2 commit -m "$msg" &&
>
> The same comment applies to the previous one.

In his original submission, Nazri actually had it the way you suggest
for this test (though not the preceding test), but changed it in
response to a silly parenthetical "IMHO" in my review [1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/233636/focus=233704
