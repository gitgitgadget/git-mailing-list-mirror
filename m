From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/6] Add concept of 'publish' branch
Date: Sun, 1 Sep 2013 06:20:18 -0500
Message-ID: <CAMP44s1x=7k3XTPSzHFk4gtJBY301mVbsQWammsp3HpdSzp2CA@mail.gmail.com>
References: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
	<1378024002-26190-3-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cQUiSC4r01nSqRnrDj230x=tUK4dGUXhWrUitSAVKZ-Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Sep 01 13:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG5hg-0007By-2B
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 13:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757214Ab3IALUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 07:20:20 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:56017 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab3IALUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 07:20:19 -0400
Received: by mail-lb0-f171.google.com with SMTP id u14so3121091lbd.16
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 04:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6K0GcU9NdG9E1DEQCh3KSb/+E1usGYyeNjB9dGagoec=;
        b=w6fVCTF2vN5DsSaZoPDOX5A6VWRRs9MyGq6/wgDBj8lmc4UTqzoUTo9i1ZG8Y5XFb1
         gs6DEjEZrrf4YWolSLYdxMWjSYKqMbEHHN32t8GDmKMQ4dnOP/loACrn68gDB0s0bhEu
         y2Ck1jZckV1CYb8scNKllG17Asg4tj5OyMNvCq8zimtMjsGiPFucqZfFnJO2MndvwaEy
         pSy1Qx4rzSJpxP6cxlBGq++xjviPzsxMb3BAFwjj8JX08BtA8exhnxTEzwyJPWASLzAX
         bsjQJVXKEmysZq4mIN2yLKj8fZ+IakuNl5tCJexuzQ+qXieyOAZ108x23Y3EtaEQCzzk
         zaAQ==
X-Received: by 10.112.14.3 with SMTP id l3mr1343187lbc.27.1378034418094; Sun,
 01 Sep 2013 04:20:18 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sun, 1 Sep 2013 04:20:18 -0700 (PDT)
In-Reply-To: <CAPig+cQUiSC4r01nSqRnrDj230x=tUK4dGUXhWrUitSAVKZ-Wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233584>

On Sun, Sep 1, 2013 at 3:41 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Sep 1, 2013 at 4:26 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:

>> +static void setup_push_simple(struct remote *remote, struct branch *branch,
>> +                               int triangular)
>> +{
>> +       if (branch->push_name) {
>> +               struct strbuf refspec = STRBUF_INIT;
>> +               strbuf_addf(&refspec, "%s:%s", branch->name, branch->push_name);
>> +               add_refspec(refspec.buf);
>
> strbuf_release(&refspec);

Actually no, wee need that buffer. See setup_push_upstream().

-- 
Felipe Contreras
