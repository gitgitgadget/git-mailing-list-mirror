From: Ruben Kerkhof <ruben@rubenkerkhof.com>
Subject: Re: [PATCH] send-email: If the ca path is not specified, use the defaults
Date: Wed, 15 Jan 2014 22:50:00 +0100
Message-ID: <5AD43B9B-A9E3-48CA-919C-4AB54F122F92@rubenkerkhof.com>
References: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com> <xmqqa9ex2gi6.fsf@gitster.dls.corp.google.com> <7AD1C6ED-6177-415D-B342-D1FEA9F810B4@rubenkerkhof.com> <xmqqob3d0w7g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Igor Gnatenko <i.gnatenko.brain@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 22:50:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3YLi-00007G-Bf
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 22:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752152AbaAOVuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 16:50:06 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:44033 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbaAOVuD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 16:50:03 -0500
Received: by mail-ea0-f174.google.com with SMTP id b10so744993eae.33
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 13:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubenkerkhof.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=d0h5nZjag51PPNSP/fzy6pZgoaWdkosxA+8p3Bhn5UQ=;
        b=Y4Au1oSlBL8/PBByfZ5NDboEgSuWve0Ic6sTMb7Uzk21ohtN7Uoe4K+DfLDP+2EjAO
         CaQhxK8fy8ErDihpwPZvXG0M/IFeYR9VHrV44Le+wlAh0J9HqTuld7ecs06wKXYfBmL8
         U4fUWnPxRe1D4HGxSOJ6UoU2XY+EYTxq3osiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=d0h5nZjag51PPNSP/fzy6pZgoaWdkosxA+8p3Bhn5UQ=;
        b=J0tECdt/dJU5WjTwAd0vGek8Tw0CZS/mPGb3SZia8zMMZNb8RskMMhYLbhnXNi4i8h
         GHiuKw54KUuDw8bTULNnGYnqx+MOwZptEh6wyQlsEmy+2wr2ysoC7OyqZiFkh8Nz9Hrd
         dhMJTuuOIoxrU/M2XtHkleov3d9sPDUqph4tD9UMRSvp3gcb4dYayMAfASlKuaemXpeM
         VKjgZpogNpsEF9WmEpAGwZSRO6FM5EI/kzFU92WaKUf+D07+NYurlXRxdJ45Kk5YvnZU
         AONHIIsvfaf1P/eXTVZ+jzlGiSTFaKQV3+hp4vXrHwFfEHossdJ9q8bli1NrvjkjnJey
         dTlw==
X-Gm-Message-State: ALoCoQkZ4MCLdgsWvFOTCRhNe1lhJ93yWDaaFaU15mIemFR8uERVdhRPsjCNYHV7ttB32O/6+nH6
X-Received: by 10.15.26.6 with SMTP id m6mr6444554eeu.80.1389822602512;
        Wed, 15 Jan 2014 13:50:02 -0800 (PST)
Received: from [192.168.178.9] (5354AD63.cm-6-5c.dynamic.ziggo.nl. [83.84.173.99])
        by mx.google.com with ESMTPSA id 7sm13512764eee.12.2014.01.15.13.50.00
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 15 Jan 2014 13:50:01 -0800 (PST)
In-Reply-To: <xmqqob3d0w7g.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240480>


On 15 jan. 2014, at 22:30, Junio C Hamano <gitster@pobox.com> wrote:

> Ruben Kerkhof <ruben@rubenkerkhof.com> writes:
> 
>>> ... because?  Is it because the cert_path on your platform is
>>> different from /etc/ssl/certs?  What platform was this anyway?
>> 
>> This is Fedora rawhide, git-1.8.5.2-1.fc21.x86_64, perl-IO-Socket-SSL-1.962-1.fc21.noarch
>>> 
>>> I see in the original discussion in your bugzilla entry that
>>> "/etc/ssl/certs/" _is_ your ssl cert directory, but I wonder why
>>> then this part of the existing codepath does not work for you:
>> 
>> Actually, it's not a directory but a symlink to a directory:
>> 
>> [ruben@vm ~]$ ls -l /etc/ssl/certs
>> lrwxrwxrwx. 1 root root 16 Jan 11 12:04 /etc/ssl/certs -> ../pki/tls/certs
>> 
>> Just to rule that out I set smtpsslcertpath = /etc/pki/tls/certs,
>> but that doesn't work either.
> 
> Yeah, I suspect as much, as "-d" test would dereference symlinks and
> would see /etc/ssl/certs is a symlink pointing at a directory.
> 
>> ...  I posted the patch to Fedora's bugzilla, since this was
>> biting me on Fedora, and Igor took the liberty to forward it.  Not
>> that I mind of course, but please don't take this patch as a
>> proper fix. I don't pretend to fully understand the code and the
>> implications, much less the impact on other platforms.
> 
> That is fine, and thanks for starting discussion for a proper fix
> (the "thanks" go to both of you).
> 
>>> Also, if the above observation is correct, i.e. we are calling
>>> IO::Socket::SSL with SSL_ca_path set to a correct directory but
>>> somehow your platform is misbehaving and not detecting it as a
>>> proper SSL_ca_path, then it could be argued that the code before
>>> this patch catered people on platforms with one class of breakage,
>>> namely "IO::Socket::SSL does not work with default configuration
>>> without SSL_ca_file nor SSL_ca_path", and the code with this patch
>>> caters people on platforms with another class of breakage, namely
>>> "IO::Socket::SSL does not work when told with SSL_ca_path where the
>>> certificate directory is" (or it could be "/etc/ssl/certs is a
>>> directory that ought to be usable as SSL_ca_path, but it lacks
>>> necessary hash symlinks").  Sort of like robbing Peter to pay Paul,
>>> which is not very nice in principle.
>> 
>> I suspect that's exactly the case,...
> 
> Actually, there is another possibility.  Perhaps on your system,
> even though the current code thinks /etc/ssl/certs/ is usable as
> SSL_ca_path, the directory is not meant to be usable as such, and
> the default OpenSSL uses the equivalent of SSL_ca_file and uses the
> single certificate bundle file without consulting other stuff in the
> directory.
> 
> And that is not a broken installation at all, which is sort of
> consistent with your observation here: 
> 
>> ...
>> As a last check, I set smtpsslcertpath = /etc/pki/tls/cert.pem in
>> ~/.gitconfig and git-send-email works fine now.
> 
> Which would mean that the existing code, by blindly defaulting to
> /etc/ssl/certs/ and misdiagnosing that the directory is meant to be
> used as SSL_ca_path, breaks a set-up that otherwise _should_ work.

Exactly. IO::Socket::SSL calls Net::SSLeay::CTX_load_verify_locations( $ctx, $arg_hash->{SSL_ca_file} || '',$arg_hash->{SSL_ca_path} || ''),
which in turn calls OpenSSL's SSL_CTX_load_verify_locations

According to the comments at http://www.openssl.org/docs/ssl/SSL_CTX_load_verify_locations.html, the CApath should be a directory with hashes pointing to
to certs, which is not the case in Fedora.
> 
> I see that the original change that introduced the defaulting to
> /etc/ssl/certs/, which is 35035bbf (send-email: be explicit with SSL
> certificate verification, 2013-07-18), primarily wanted to avoid
> letting Net::SMTP::SSL defaulting to no verification and causing it
> to emit warnings of the use of the insecure default.  And I think
> the same outcome will result with your patch.  By default, we still
> insist on using SSL_VERIFY_PEER(), not SSL_VERIFY_NONE(), which
> would avoid defaulting to insecure communication and triggering the
> warning.  The way to disable the security by setting ssl_cert_path
> to an empty string is unchanged.
> 
> Ram (who did 35035bbf), with the patch from Ruben in the thread, do
> you get either the warning or SSL failure?  Conceptually, the
> resulting code is much better, I think, without blindly defaulting
> /etc/ssl/certs and instead of relying on the underlying platform
> just working out of the box with its own default, and I would be
> happy if we can apply the change without regression to existing
> users.


/etc/pki/tls/cert.pem is a symlink to the Mozilla CA bundle,
/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem, which as far as I can tell is the one that should be used for this distro.

Kind regards,

Ruben