From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH v2] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 19:29:08 +0100
Message-ID: <CAFXTnz7r79JYXQBBcpiOPtUzeafuN3fa82F5rGXd-Hr7tSAEOw@mail.gmail.com>
References: <1358928767-16283-1-git-send-email-hjemli@gmail.com>
	<7v622nj0ys.fsf@alter.siamese.dyndns.org>
	<7vwqv3hlu7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 19:29:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty54n-00065t-4Y
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 19:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab3AWS3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 13:29:11 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]:44840 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab3AWS3J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 13:29:09 -0500
Received: by mail-bk0-f54.google.com with SMTP id w5so1372961bku.27
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 10:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=9nrGNCy14B320LYuRPA4DVYRn0MPNwmUs5uHFi+qg3E=;
        b=Eyw1BsjF1QIKxuXQQpen9vucb3FWcu/i3H/xf6lqRINunNO8J8mdORQVYZuPAyWr75
         /7fIM3jSLvfSc9UatwI2HoWVbMrqLzMosWwN8sGDjyH4Ej0WmqgfbhlXaOk/DJBlmMrv
         ZhTnLl8j8gKbctwAUw9xt6nZQ2nUcCWmwi8PMnO5P6WAygGhMcitE8s2y3xxeo22VZ3z
         Ego7JVvHLxz7J0b0oaitrrhEhG9b2G4v2bmNtAirxqhCbHdEpf4CRUUEjZ4X9PQr2Mtc
         9x6M6baMiD7woMQxHWmTF9exTRu59Bo801MtQFfaRFM81jC5FbtbR2QkmeylqsEEP6BT
         EpMg==
X-Received: by 10.204.147.67 with SMTP id k3mr763881bkv.117.1358965748379;
 Wed, 23 Jan 2013 10:29:08 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Wed, 23 Jan 2013 10:29:08 -0800 (PST)
In-Reply-To: <7vwqv3hlu7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214341>

On Wed, Jan 23, 2013 at 6:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> But I still do not think this loop is correct.  In a repository that
>> has a working tree, you would learn that directory $D has $D/.git in
>> it, feed $D to handle_repo(), and then descend into $D/.git/objects/,
>> $D/.git/refs, and other random directories to see if you can find
>> other repositories....
>
> Ahh, no, you don't.
>
> I still think calling is_git_directory() on $D + "/.git" would be a
> better implementation, though.

Except for the .gitfile case, which is_git_directory() doesn't seem to
handle. I guess I can invoke read_gitfile() when i see that .git is a
file.

-- 
larsh
