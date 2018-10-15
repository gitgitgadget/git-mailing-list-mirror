Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B911F453
	for <e@80x24.org>; Mon, 15 Oct 2018 12:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeJOUSu (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 16:18:50 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:41946 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbeJOUSt (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Oct 2018 16:18:49 -0400
Received: from mxback12g.mail.yandex.net (mxback12g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:91])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id C2F694083A2E
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 15:33:40 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback12g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id GHTHbSIVhP-XeuiIWSQ;
        Mon, 15 Oct 2018 15:33:40 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1539606820;
        bh=cKvPVg+iQv/+NXX9KWE8fF8NF+6630EtbkDcLQpd+Jc=;
        h=From:To:Subject:Date:Message-Id;
        b=JzlAAWFDvxvJLTt08WpGTnokV8OlCEoRAtUtLzHLLVLgT7NAediBOvJ/jxY+kdjk6
         uR0iC97P2lNS5Vhcv5liSCz9wxfI8corlGt5Yir1ygSx1/nsQXIOHu7yY2YMrNvdPt
         8YRrkGxjjA1wPW9oXiub6+oCiRZeNTQ+PQprCerk=
Authentication-Results: mxback12g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-f9d71769b752.qloud-c.yandex.net with HTTP;
        Mon, 15 Oct 2018 15:33:40 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git <git@vger.kernel.org>
Subject: Case when I can not unstage the hunk
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 15 Oct 2018 15:33:40 +0300
Message-Id: <9994851539606820@myt5-f9d71769b752.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. 
Here is log:

git reset HEAD -p /home/kes/s/public/v2/js/contact_us.js
diff --git a/public/v2/js/contact_us.js b/public/v2/js/contact_us.js
index e05be6d0..d429d291 100644
--- a/public/v2/js/contact_us.js
+++ b/public/v2/js/contact_us.js
@@ -1,7 +1,19 @@
+
+
+function captchaProcess( form ) {
+      var id =  $(form).find( 'textarea[name=g-recaptcha-response]' )
+        .attr( 'id' ).match( /\d+$/ );
+      if( id ){ id =  id[0] } else { id = 0 }
+      grecaptcha.reset( Number( id ) );
+      grecaptcha.execute( Number( id ) );
+      // When .execute is done this will trigger callback
+      // which is specified on g-recaptcha div element via data-callback attr
+}
+
+
 // FORM VALIDATION
-var validator;
 $(function(){
-  validator =  $('#contact_us-form').validate({
+  $('#contact_us-form').validate({
     rules: {
       name: {
         required: true,
Unstage this hunk [y,n,q,a,d,j,J,g,/,s,e,?]? s
Split into 3 hunks.
@@ -1 +1,14 @@
+
+
+function captchaProcess( form ) {
+      var id =  $(form).find( 'textarea[name=g-recaptcha-response]' )
+        .attr( 'id' ).match( /\d+$/ );
+      if( id ){ id =  id[0] } else { id = 0 }
+      grecaptcha.reset( Number( id ) );
+      grecaptcha.execute( Number( id ) );
+      // When .execute is done this will trigger callback
+      // which is specified on g-recaptcha div element via data-callback attr
+}
+
+
 // FORM VALIDATION
Unstage this hunk [y,n,q,a,d,j,J,g,/,e,?]? n
@@ -1,3 +14,2 @@
 // FORM VALIDATION
-var validator;
 $(function(){
Unstage this hunk [y,n,q,a,d,K,j,J,g,/,e,?]? y
@@ -3,5 +15,5 @@
 $(function(){
-  validator =  $('#contact_us-form').validate({
+  $('#contact_us-form').validate({
     rules: {
       name: {
         required: true,
Unstage this hunk [y,n,q,a,d,K,j,J,g,/,e,?]? y
@@ -47,12 +59,7 @@ $(function(){
       $(element).removeClass("error_inp");
     },
     submitHandler: function(form) {
-      var id =  $(form).find( 'textarea[name=g-recaptcha-response]' )
-        .attr( 'id' ).match( /\d+$/ );
-      if( id ){ id =  id[0] } else { id = 0 }
-      grecaptcha.execute( Number( id ) );
-      // When .execute is done this will trigger callback
-      // which is specified on g-recaptcha div element via data-callback attr
+      captchaProcess( form );
     }
   });
 });
Unstage this hunk [y,n,q,a,d,K,g,/,e,?]? n
error: patch failed: public/v2/js/contact_us.js:1
error: public/v2/js/contact_us.js: patch does not apply
diff --git a/public/v2/js/contact_us.js b/public/v2/js/contact_us.js
index e05be6d0..d429d291 100644
--- a/public/v2/js/contact_us.js
+++ b/public/v2/js/contact_us.js
@@ -1,7 +1,6 @@
 // FORM VALIDATION
-var validator;
 $(function(){
-  validator =  $('#contact_us-form').validate({
+  $('#contact_us-form').validate({
     rules: {
       name: {
         required: true,



DETAILS:

git diff -b -w --ignore-blank-lines /home/kes/s/public/v2/js/contact_us.js
diff --git a/public/v2/js/contact_us.js b/public/v2/js/contact_us.js
index d429d291..bd1f4ddd 100644
--- a/public/v2/js/contact_us.js
+++ b/public/v2/js/contact_us.js
@@ -1,10 +1,24 @@
 
+function show_validator_errors( xhr, validator ) {
+  if( xhr.status == 404 ) { return }
+
+  var res =  xhr.responseJSON;
+  // TODO: Display responseText if there is no responseJSON
+  if( !res ) { return };
+
+  var errors =  {};
+  // convert server response into validator format
+  for( var error in res.error.info ) {
+    errors[error] =  res.error.info[ error ][ 1 ] || 'Error';
+  }
+  validator.showErrors( errors );
+}
+
 
 function captchaProcess( form ) {
       var id =  $(form).find( 'textarea[name=g-recaptcha-response]' )
         .attr( 'id' ).match( /\d+$/ );
       if( id ){ id =  id[0] } else { id = 0 }
-      grecaptcha.reset( Number( id ) );
       grecaptcha.execute( Number( id ) );
       // When .execute is done this will trigger callback
       // which is specified on g-recaptcha div element via data-callback attr








git diff -b -w --ignore-blank-lines --staged /home/kes/s/public/v2/js/contact_us.js
diff --git a/public/v2/js/contact_us.js b/public/v2/js/contact_us.js
index e05be6d0..d429d291 100644
--- a/public/v2/js/contact_us.js
+++ b/public/v2/js/contact_us.js
@@ -1,7 +1,19 @@
+
+
+function captchaProcess( form ) {
+      var id =  $(form).find( 'textarea[name=g-recaptcha-response]' )
+        .attr( 'id' ).match( /\d+$/ );
+      if( id ){ id =  id[0] } else { id = 0 }
+      grecaptcha.reset( Number( id ) );
+      grecaptcha.execute( Number( id ) );
+      // When .execute is done this will trigger callback
+      // which is specified on g-recaptcha div element via data-callback attr
+}
+
+
 // FORM VALIDATION
-var validator;
 $(function(){
-  validator =  $('#contact_us-form').validate({
+  $('#contact_us-form').validate({
     rules: {
       name: {
         required: true,




