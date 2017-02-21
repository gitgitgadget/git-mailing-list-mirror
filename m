Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 032832021B
	for <e@80x24.org>; Tue, 21 Feb 2017 09:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbdBUJe2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 04:34:28 -0500
Received: from forward15h.cmail.yandex.net ([87.250.230.157]:56711 "EHLO
        forward15h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751069AbdBUJe1 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Feb 2017 04:34:27 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Feb 2017 04:34:26 EST
Received: from mxback3h.mail.yandex.net (mxback3h.mail.yandex.net [IPv6:2a02:6b8:0:f05::10c])
        by forward15h.cmail.yandex.net (Yandex) with ESMTP id 0991721C26
        for <git@vger.kernel.org>; Tue, 21 Feb 2017 12:24:28 +0300 (MSK)
Received: from web22g.yandex.ru (web22g.yandex.ru [95.108.253.231])
        by mxback3h.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 1BiAsDYwNo-OSj4Nmb3;
        Tue, 21 Feb 2017 12:24:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1487669068;
        bh=9qDLSKYe6yWvfUsY427JHRdF/KhpzfPjzvUUcWQfytg=;
        h=From:To:Subject:Message-Id:Date;
        b=RyuUkB1Q4UaWjT4aBE/PYXbjXzEwcuHagWlk3wVo5Vd6v8+Uh9f9SMAgr2D59j+8C
         aT1xwmwI+QLT6x+XMr6NttrqVQl+Lsad2oImfxEg1YTZnD7DAmr9n1WwwMhbpH8FtW
         kNJ3K3f96YETV8wWb1/vq6y6Js2WLnI4fHIZs2YM=
Authentication-Results: mxback3h.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web22g.yandex.ru with HTTP;
        Tue, 21 Feb 2017 12:24:28 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:     git <git@vger.kernel.org>
Subject: Not expected merge conflict output
MIME-Version: 1.0
Message-Id: <16011487669068@web22g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 21 Feb 2017 11:24:28 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. I have merge conflict and this output:

--- a/crypto/lib/Crypto/Routes.pm
+++ b/crypto/lib/Crypto/Routes.pm
@@@ -98,17 -94,16 +98,36 @@@ sub register 
          ,payment_cancel_landing  =>  '/payment-cancel'
      }});
      # Route configuration is moved from plugin:
++<<<<<<< ours
 +    $rn->get( '/stripe/payment_success' )->to( 'Stripe#payment_success' )->name( 'stripe_payment_s
 +    $rn->get( '/stripe/payment_cancel'  )->to( 'Stripe#payment_cancel'  )->name( 'stripe_payment_c
 +    $rn->options( '/stripe' )->to( 'Stripe#options' )->name( 'stripe_options' );
 +    $rn->post( '/stripe/payment/create', { required_level => 'user' } )->to( 'Stripe#payment_creat
 +    $rn->post( '/stripe/payment/execute', { required_level => 'user' } )->to( 'Stripe#payment_exec
++||||||| base
++    $guest->get( '/stripe/payment_success' )->to( 'Stripe#payment_success' )->name( 'stripe_paymen
++    $guest->get( '/stripe/payment_cancel'  )->to( 'Stripe#payment_cancel'  )->name( 'stripe_paymen
++    $guest->options( '/stripe' )->to( 'Stripe#options' )->name( 'stripe_options' );
++    $user->post( '/stripe/payment/create'  )->to( 'Stripe#payment_create'  )->name( 'stripe_paymen
++    $user->post( '/stripe/payment/execute' )->to( 'Stripe#payment_execute' )->name( 'stripe_paymen
++
++    $guest->post( '/stripe/hook' )->to( 'Stripe#hook' )->name( 'stripe_hook' );
++=======
+     $guest->get( '/stripe/payment_success' )->to( 'Stripe#payment_success' )->name( 'stripe_paymen
+     $guest->get( '/stripe/payment_cancel'  )->to( 'Stripe#payment_cancel'  )->name( 'stripe_paymen
+     $guest->options( '/stripe' )->to( 'Stripe#options' )->name( 'stripe_options' );
+     $user->post( '/stripe/payment/create'  )->to( 'Stripe#payment_create'  )->name( 'stripe_paymen
+     $user->post( '/stripe/payment/execute' )->to( 'Stripe#payment_execute' )->name( 'stripe_paymen
+ 
+     $guest->post( '/stripe/hook' )->to( 'Stripe#hook' )->name( 'stripe_hook' );
+     $guest->get ( '/stripe/:form' )->to( 'Stripe#button' );
++>>>>>>> theirs
  
 +    $rn->post( '/stripe/hook' )->to( 'Stripe#hook' )->name( 'stripe_hook' );
  
 +    # Static routes
 +    # QR code dowlnload url
 +    $app->routes->get('/uploads/qrcode/:file')->name('qr_url');


But I expect this output:

--- a/crypto/lib/Crypto/Routes.pm
+++ b/crypto/lib/Crypto/Routes.pm
@@@ -98,17 -94,16 +98,36 @@@ sub register 
          ,payment_cancel_landing  =>  '/payment-cancel'
      }});
      # Route configuration is moved from plugin:
++<<<<<<< ours
 +    $rn->get( '/stripe/payment_success' )->to( 'Stripe#payment_success' )->name( 'stripe_payment_s
 +    $rn->get( '/stripe/payment_cancel'  )->to( 'Stripe#payment_cancel'  )->name( 'stripe_payment_c
 +    $rn->options( '/stripe' )->to( 'Stripe#options' )->name( 'stripe_options' );
 +    $rn->post( '/stripe/payment/create', { required_level => 'user' } )->to( 'Stripe#payment_creat
 +    $rn->post( '/stripe/payment/execute', { required_level => 'user' } )->to( 'Stripe#payment_exec
  
 +    $rn->post( '/stripe/hook' )->to( 'Stripe#hook' )->name( 'stripe_hook' );
++||||||| base
++    $guest->get( '/stripe/payment_success' )->to( 'Stripe#payment_success' )->name( 'stripe_paymen
++    $guest->get( '/stripe/payment_cancel'  )->to( 'Stripe#payment_cancel'  )->name( 'stripe_paymen
++    $guest->options( '/stripe' )->to( 'Stripe#options' )->name( 'stripe_options' );
++    $user->post( '/stripe/payment/create'  )->to( 'Stripe#payment_create'  )->name( 'stripe_paymen
++    $user->post( '/stripe/payment/execute' )->to( 'Stripe#payment_execute' )->name( 'stripe_paymen
++
++    $guest->post( '/stripe/hook' )->to( 'Stripe#hook' )->name( 'stripe_hook' );
++=======
+     $guest->get( '/stripe/payment_success' )->to( 'Stripe#payment_success' )->name( 'stripe_paymen
+     $guest->get( '/stripe/payment_cancel'  )->to( 'Stripe#payment_cancel'  )->name( 'stripe_paymen
+     $guest->options( '/stripe' )->to( 'Stripe#options' )->name( 'stripe_options' );
+     $user->post( '/stripe/payment/create'  )->to( 'Stripe#payment_create'  )->name( 'stripe_paymen
+     $user->post( '/stripe/payment/execute' )->to( 'Stripe#payment_execute' )->name( 'stripe_paymen
+ 
+     $guest->post( '/stripe/hook' )->to( 'Stripe#hook' )->name( 'stripe_hook' );
+     $guest->get ( '/stripe/:form' )->to( 'Stripe#button' );
++>>>>>>> theirs
  
 +    # Static routes
 +    # QR code dowlnload url
 +    $app->routes->get('/uploads/qrcode/:file')->name('qr_url');

Because this diff has less difference between ours&&base, Also 

This (second expected patch)
 +    # Static routes
 +    # QR code dowlnload url
 +    $app->routes->get('/uploads/qrcode/:file')->name('qr_url');
is less in compare to (first not expected):
  
 +    $rn->post( '/stripe/hook' )->to( 'Stripe#hook' )->name( 'stripe_hook' );
  
 +    # Static routes
 +    # QR code dowlnload url
 +    $app->routes->get('/uploads/qrcode/:file')->name('qr_url');


Did I wrong and first output is right thing or maybe I right and I should open new bug report.
Please explain me
